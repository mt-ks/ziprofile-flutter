import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziprofile/exceptions/social_exception.dart';
import 'package:ziprofile/providers/profile_loader_provider.dart';
import 'package:ziprofile/screens/app/user_screen.dart';
import 'package:ziprofile/utils/shared_prefs.dart';
import 'package:ziprofile/widgets/custom_dialog.dart';
import 'package:ziprofile/widgets/loading_dialog.dart';
import '../../models/user.dart';
import '../../providers/search_provider.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/scaffold_snackbar.dart';

import '../welcome_screen.dart';

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
    if (SharedPrefs().userStorage.getIsFastAuth() == false) {
      _search();
    } else {
      ScaffoldSnackbar(
          context: context,
          message: "Arama yapmak için oturum açmanız gerekiyor!");
    }
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
      _loadingDialog.hideDialog();
    } catch (e, stackTrace) {
      _loadingDialog.hideDialog();
      if (e is SocialException) {
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

  void _loadUser(User user, BuildContext ctx) {
    _loadingDialog.showLoaderDialog();
    ProfileLoaderProvider(
      user: user,
      onLoadSuccess: (value) {
        _loadingDialog.hideDialog();
        Navigator.of(ctx).push(
          MaterialPageRoute(
            builder: (ctx) => UserScreen(
              naviagorKey: navigatorKey,
              response: value,
            ),
          ),
        );
      },
      onLoadFailed: (value) {
        _loadingDialog.hideDialog();
        ScaffoldSnackbar(
          context: context,
          message: value,
        );
      },
      onLoginRequired: () {
        _loadingDialog.hideDialog();
        _loginRequiredDialog();
      },
      onOpenNeedSubscription: () {
        _loadingDialog.hideDialog();
        showDialog(
          context: context,
          builder: ((_) {
            return CustomDialog(
              title: "Abonelik Gerekli",
              description:
                  "Bu hizmeti alabilmek için ücretli abonelik satın almanız gerekmektedir.",
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: Text('Abonelik Satın Al'),
                ),
              ],
            );
          }),
        );
      },
    );
  }

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
    print("auth state");
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
          SharedPrefs().userStorage.getIsFastAuth()
              ? Container(
                  margin: EdgeInsets.only(bottom: 15),
                  color: Colors.yellow[800],
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Arama yapmak için oturum açmalısınız! Aşağıda rastgele gizli profiller listelenir.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              : Container(),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: searchInputController,
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
            child: SharedPrefs().userStorage.getIsFastAuth()
                ? _nonAuthListView()
                : searchListView(ctx),
          ),
        ],
      ),
    );
  }

  ListView searchListView(BuildContext ctx) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        var user = provider.searchResult!.users[index];
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
              provider.searchResult?.users[index].full_name ?? "...",
              style: TextStyle(color: Colors.white),
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: CachedImage(
                  imageUrl:
                      provider.searchResult?.users[index].profile_pic_url),
            ),
          ),
        );
      }),
      itemCount: provider.searchResult?.users.length ?? 0,
    );
  }

  _nonAuthListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        var user = provider.m2xResponse!.userResponses[index].info;
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => UserScreen(
                  naviagorKey: navigatorKey,
                  response: provider.m2xResponse!.userResponses[index],
                ),
              ),
            );
          },
          child: ListTile(
            title: Row(children: [
              Text(
                user?.username ?? "...",
                style: TextStyle(color: Colors.white),
              ),
              Padding(padding: EdgeInsets.only(left: 7)),
              (user?.is_verified == true)
                  ? Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 16,
                    )
                  : Container(),
              (user?.is_private == true)
                  ? Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 16,
                    )
                  : Container(),
            ]),
            subtitle: Text(
              user?.full_name ?? "...",
              style: TextStyle(color: Colors.white),
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: CachedImage(imageUrl: user?.profile_picture),
            ),
          ),
        );
      },
      itemCount: provider.m2xResponse?.userResponses.length ?? 0,
    );
  }

  @override
  void dispose() {
    searchInputController.dispose();
    super.dispose();
  }
}
