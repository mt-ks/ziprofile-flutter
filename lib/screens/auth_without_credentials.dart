import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:ziprofile/exceptions/social_exception.dart';
import 'package:ziprofile/models/user.dart';
import 'package:ziprofile/services/m2x_service.dart';
import 'package:ziprofile/services/social_service.dart';
import 'package:ziprofile/utils/shared_prefs.dart';
import 'package:ziprofile/widgets/custom_textfield.dart';
import 'package:ziprofile/widgets/loading_dialog.dart';
import 'package:ziprofile/widgets/scaffold_snackbar.dart';

import 'app_screen.dart';

class AuthWithoutCredentialsScreen extends StatefulWidget {
  static String routeName = '/fast-auth';
  const AuthWithoutCredentialsScreen({super.key});

  @override
  State<AuthWithoutCredentialsScreen> createState() =>
      _AuthWithoutCredentialsScreenState();
}

class _AuthWithoutCredentialsScreenState
    extends State<AuthWithoutCredentialsScreen> {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Devam Et'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 40)),
            Text(
              'Size Nasıl Hitap Edelim?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Raleway',
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              'Bir kullanıcı adı tanımlamak bu uygulamada oturum açmadan devam etmenizi sağlar.',
              style: TextStyle(color: Colors.grey, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            CustomTextField(
              controller: textController,
              icon: Icons.person,
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            ElevatedButton(
              onPressed: () {
                _findUserAndNavigate();
              },
              child: Text('Devam Et'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[900],
                minimumSize: const Size.fromHeight(50), // NEW
              ),
            ),
          ],
        ),
      ),
    );
  }

  _findUserAndNavigate() async {
    var loadingDialog = LoadingDialog(context: context);
    loadingDialog.showLoaderDialog();
    var username = textController.text;
    if (username.isEmpty || username.length < 4) {
      loadingDialog.hideDialog();
      ScaffoldSnackbar(
          context: context,
          message: "Kullanıcı adınız en az 4 karakterli olmalıdır.");
      return;
    }

    var deviceInfo = await DeviceInfoPlugin().iosInfo;
    var id = deviceInfo.identifierForVendor;
    String avatarUrl =
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
    var fast_user = User(id, username, username, false, avatarUrl, "", false,
        false, "", "", null, 0, 0, 0);
    SharedPrefs().userStorage.setIsFastAuth(true);
    SharedPrefs().userStorage.setBearerToken("fast_auth");
    SharedPrefs().userStorage.setOauthToken("fast_auth");
    SharedPrefs().userStorage.setUsername("fast_auth");
    SharedPrefs().userStorage.setCurrentUser(fast_user);
    await _getUserListAndSave();
    loadingDialog.hideDialog();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppScreen.routeName, (r) => false);
  }

  _getUserListAndSave() async {
    var response = await M2XService().getList();
    SharedPrefs().userStorage.setM2XUserList(response);
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }
}
