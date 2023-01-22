import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './reset_password_screen.dart';
import './signup_screen.dart';
import '../services/api_service.dart';
import '../widgets/custom_textfield.dart';
import '../exceptions/api_exception.dart';
import '../utils/shared_prefs.dart';
import '../widgets/scaffold_snackbar.dart';
import 'app_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = 'welcome';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _login(String email, String password) async {
    try {
      var login = await ApiService().login(email, password);
      SharedPrefs().oauth2Storage.setOauthToken(login.token);
      SharedPrefs().oauth2Storage.setCurrentUser(login);
      _navigateToAppScreen();
    } on APIException catch (e) {
      ScaffoldSnackbar(context: context, message: e.message);
    }
  }

  _navigateToAppScreen() {
    Future.delayed(Duration.zero, () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppScreen.routeName, (r) => false);
    });
  }

  _signUp() {
    Navigator.of(context).pushNamed(SignUpScreen.routeName);
  }

  _resetPassword() {
    Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Center(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _resetPassword();
                      },
                      child: Text(
                        'Şifreni mi Unuttun?',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ButtonStyle(alignment: Alignment.topRight),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    String email = emailController.text;
                    String password = passwordController.text;
                    if (email.trim() == '' || !email.contains('@')) {
                      ScaffoldSnackbar(
                        context: context,
                        message: 'Lütfen geçerli bir e-posta adresi giriniz.',
                      );
                      return;
                    }

                    if (password.isEmpty || password.length < 3) {
                      ScaffoldSnackbar(
                        context: context,
                        message: 'Lütfen geçerli bir şifre giriniz.',
                      );
                      return;
                    }

                    _login(emailController.text, passwordController.text);
                  },
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
                  onPressed: () => _signUp(),
                  child: Text(
                    'Hesabın yok mu? Kayıt Ol.',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
