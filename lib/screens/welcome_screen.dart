import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ziprofile/screens/auth_without_credentials.dart';
import 'package:ziprofile/screens/signin_screen.dart';
import 'package:ziprofile/services/m2x_service.dart';
import 'package:ziprofile/services/social_service.dart';
import 'package:ziprofile/widgets/custom_dialog.dart';
import 'package:ziprofile/widgets/custom_textfield.dart';
import '../screens/auth_screen.dart';
import '../services/network_connectivity.dart';
import '../utils/shared_prefs.dart';
import '../widgets/scaffold_snackbar.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = 'welcome';
  const WelcomeScreen({super.key});

  void _routeToAuthScreen(BuildContext context) async {
    var hasInternet = await NetworkConnectivity.checkConnection();
    if (!hasInternet) {
      ScaffoldSnackbar(
        context: context,
        message: "Lütfen internet bağlantınızı kontrol edin!",
      );
      return;
    }
    var config = SharedPrefs().cloudStorage.getConfig();
    Navigator.of(context).pushNamed(SignInScreen.routeName, arguments: config);
  }

  _test() async {
    // var rq = await M2XService().getList();
    // print(rq.userResponses[0].info?.username);
  }

  _authWithoutCredentials(BuildContext context) {
    Navigator.of(context).pushNamed(AuthWithoutCredentialsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    _test();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/app_logo.png",
                width: 50,
              ),
              Center(
                child: Text(
                  'ZIPROFILE',
                  style: CupertinoTextThemeData().textStyle.copyWith(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Gizli profilleri birleştirir.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 12),
              CustomTextField(
                controller: emailController,
                icon: Icons.email_outlined,
                hintText: "E-Posta adresiniz",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: passwordController,
                icon: Icons.lock_open_outlined,
                hintText: "Şifreniz",
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => _routeToAuthScreen(context),
                child: Text(
                  'Oturum Aç',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[900],
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
              ),
              TextButton(
                  onPressed: () {
                    _authWithoutCredentials(context);
                  },
                  child: Text('Hesabın yok mu? Kayıt Ol.')),
            ],
          ),
        ),
      ),
    );
  }
}
