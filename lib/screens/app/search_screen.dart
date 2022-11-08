import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziprofile/providers/profile_loader_provider.dart';
import 'package:ziprofile/widgets/loading_dialog.dart';
import '../../models/user.dart';
import '../../providers/search_provider.dart';
import '../../widgets/scaffold_snackbar.dart';

import '../../icons/nav_icons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.navigatorKey});
  final navigatorKey;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchInputController = TextEditingController();
  late SearchProvider provider;
  late LoadingDialog _loadingDialog;

  void _search() async {
    if (searchInputController.text.isEmpty) {
      ScaffoldSnackbar(
        context: context,
        message: 'Kullanıcı adı boş bırakılamaz.',
      );
      return;
    }
    // lets search user...
    _loadingDialog.showLoaderDialog();
    await provider.searchUsers(searchInputController.text);
    _loadingDialog.hideDialog();
  }

  void _loadUser(User user) {
    ProfileLoaderProvider(
      user: user,
      onLoadSuccess: (value) {},
      onLoadFailed: (value) {},
      onOpenNeedSubscription: (value) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SearchProvider>(context);
    _loadingDialog = LoadingDialog(context: context);
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
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: IntrinsicHeight(
                  child: ElevatedButton(
                    onPressed: () => _search(),
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
            child: ListView.builder(
              itemBuilder: ((context, index) {
                var user = provider.searchResult!.users[index];
                return InkWell(
                  onTap: () => _loadUser(user),
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
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        imageUrl: provider
                                .searchResult?.users[index].profile_pic_url ??
                            "...",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              itemCount: provider.searchResult?.users.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchInputController.dispose();
    super.dispose();
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.none,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(
          NavIcons.search_icon,
          size: 19,
        ),
        prefixIconColor: Colors.white,
        fillColor: Color.fromARGB(255, 24, 24, 24),
        filled: true,
        hintText: 'Kullanıcı adı',
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
    );
  }
}
