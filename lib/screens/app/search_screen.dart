import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../exceptions/api_exception.dart';
import '../../models/private_user/private_user.dart';
import './user_screen.dart';
import '../../services/api_service.dart';
import '../../utils/shared_prefs.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/loading_dialog.dart';
import '../../providers/search_provider.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/scaffold_snackbar.dart';

import '../welcome_screen.dart';
import 'purchase_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.navigatorKey});
  final navigatorKey;

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState(navigatorKey: navigatorKey);
}

class _SearchScreenState extends State<SearchScreen> {
  final navigatorKey;
  _SearchScreenState({required this.navigatorKey});
  var searchInputController = TextEditingController();
  late SearchProvider provider;
  late LoadingDialog _loadingDialog;

  void _loginRequiredDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: "Oturumunuz Sona Erdi",
          description: "Tekrar oturum açmanız gerekmektedir.",
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                SharedPrefs().userStorage.removeAll();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  WelcomeScreen.routeName,
                  (r) => false,
                );
              },
              child: Text('Oturum Aç'),
            )
          ],
        );
      },
    );
  }

  void _searchRouter() {
    _search();
  }

  void _search() async {
    if (searchInputController.text.isEmpty) {
      ScaffoldSnackbar(
        context: context,
        message: 'Kullanıcı adı boş bırakılamaz.',
      );
      return;
    }
    // lets search user...
    try {
      _loadingDialog.showLoaderDialog();
      await provider.searchUsers(searchInputController.text);
      if (provider.searchResponse?.users.length == 0) {
        ScaffoldSnackbar(context: context, message: 'Kullanıcıyı bulunamadı!');
      }
      _loadingDialog.hideDialog();
    } catch (e) {
      _loadingDialog.hideDialog();
      if (e is APIException) {
        if (e.loginRequired) {
          _loginRequiredDialog();
        }
      } else {
        ScaffoldSnackbar(
          context: context,
          message: "Beklenmedik bir hata oluştu!",
        );
      }
    }
  }

  void _loadUser(PrivateUser user, BuildContext ctx) async {
    _loadingDialog = LoadingDialog(context: context);
    try {
      _loadingDialog.showLoaderDialog();
      var result = await ApiService().getUserInfo(user.pk);
      _loadingDialog.hideDialog();

      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (ctx) => UserScreen(
            naviagorKey: navigatorKey,
            response: result,
          ),
        ),
      );
    } on APIException catch (e) {
      _loadingDialog.hideDialog();
      if (e.errorType == 'need_subscription') {
        showDialog(
            context: context,
            builder: ((context) {
              return CustomDialog(
                title: e.errorTitle,
                description: e.errorDescription,
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Geri'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PurchaseScreen(),
                          ));
                        },
                        child: Text('Abonelik Satın Al'),
                      ),
                    ],
                  )
                ],
              );
            }));
      }
      ScaffoldSnackbar(context: context, message: e.message);
    }
  }

  //_navigateTo

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SearchProvider>(context);
    _loadingDialog = LoadingDialog(context: context);
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: ((ctx) {
            return pageContent(ctx);
          }),
        );
      },
    );
  }

  Scaffold pageContent(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Kullanıcı ara',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: searchInputController,
                  hintText: 'Kullanıcı adı',
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: IntrinsicHeight(
                  child: ElevatedButton(
                    onPressed: () => _searchRouter(),
                    child: Text('Ara'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 24, 24, 24),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: searchListView(ctx),
          ),
        ],
      ),
    );
  }

  ListView searchListView(BuildContext ctx) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        var user = provider.searchResponse!.users[index];
        return InkWell(
          onTap: () => _loadUser(user, ctx),
          child: ListTile(
            title: Row(children: [
              Text(
                user.username ?? "...",
                style: TextStyle(color: Colors.white),
              ),
              Padding(padding: EdgeInsets.only(left: 7)),
              (user.is_verified == true)
                  ? Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 16,
                    )
                  : Container(),
              (user.is_private == true)
                  ? Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 16,
                    )
                  : Container(),
            ]),
            subtitle: Text(
              provider.searchResponse?.users[index].full_name ?? "...",
              style: TextStyle(color: Colors.white),
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: CachedImage(
                  imageUrl:
                      provider.searchResponse?.users[index].profile_picture),
            ),
          ),
        );
      }),
      itemCount: provider.searchResponse?.users.length ?? 0,
    );
  }

  @override
  void dispose() {
    searchInputController.dispose();
    super.dispose();
  }
}
