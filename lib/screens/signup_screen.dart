import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../exceptions/api_exception.dart';
import '../services/api_service.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/scaffold_snackbar.dart';

import '../utils/shared_prefs.dart';
import '../widgets/custom_textfield.dart';
import 'app_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var currentGender = 0;
  var gender = ['Lütfen cinsiyet seçiniz.', 'Erkek', 'Kadın'];

  _register() async {
    var email = emailController.text;
    var username = usernameController.text;
    var password = passwordController.text;
    var rePassword = rePasswordController.text;
    if (email.isEmpty || !email.contains("@")) {
      _toast("Lütfen geçerli bir e-posta adresi giriniz.");
      return;
    }
    if (username.isEmpty) {
      _toast("Kullanıcı adı boş bırakılamaz.");
      return;
    }
    if (username.length < 4) {
      _toast("Kullanıcı adı en az 4 karakter olmalıdır.");
      return;
    }
    if (password.isEmpty || rePassword.isEmpty) {
      _toast("Şifre alanları boş bırakılamaz.");
      return;
    }
    if (password.length < 6 || rePassword.length < 6) {
      _toast("Şifre en az 6 karakterden oluşmalıdır.");
      return;
    }
    if (password != rePassword) {
      _toast("Şifreler uyuşmuyor");
      return;
    }
    if (currentGender == 0) {
      _toast("Lütfen cinsiyetinizi seçin.");
      return;
    }
    var loadingDialog = LoadingDialog(context: context);
    try {
      loadingDialog.showLoaderDialog();
      var register = await ApiService().register(
        email,
        username,
        password,
        rePassword,
        currentGender,
      );
      loadingDialog.hideDialog();
      SharedPrefs().oauth2Storage.setOauthToken(register.token);
      SharedPrefs().oauth2Storage.setCurrentUser(register);
      _navigateToAppScreen();
    } on APIException catch (e) {
      loadingDialog.hideDialog();
      _toast(e.message);
    }
  }

  _navigateToAppScreen() {
    Future.delayed(Duration.zero, () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppScreen.routeName, (r) => false);
    });
  }

  _toast(String message) {
    ScaffoldSnackbar(context: context, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Kayıt Ol'),
        backgroundColor: Colors.black,
      ),
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
                SizedBox(height: 12),
                CustomTextField(
                  controller: emailController,
                  icon: Icons.email_outlined,
                  hintText: "E-Posta adresiniz",
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: usernameController,
                  icon: Icons.account_circle_outlined,
                  hintText: "Kullanıcı adınız",
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: passwordController,
                  icon: Icons.lock_open_outlined,
                  hintText: "Şifreniz",
                  obscureText: true,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: rePasswordController,
                  icon: Icons.lock_open_outlined,
                  hintText: "Tekrar Şifreniz",
                  obscureText: true,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    DropdownButton(
                      items: [
                        DropdownMenuItem(
                          enabled: false,
                          child: Text(
                            "Lütfen cinsiyet seçiniz.",
                            style: TextStyle(color: Colors.white),
                          ),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Erkek",
                            style: TextStyle(color: Colors.white),
                          ),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Kadın",
                            style: TextStyle(color: Colors.white),
                          ),
                          value: 2,
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          currentGender = value == null ? 0 : value;
                        });
                      },
                      hint: Text(
                        gender[currentGender],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      dropdownColor: Colors.grey[850],
                      icon: Padding(
                        //Icon at tail, arrow bottom is default icon
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _register(),
                  child: Text(
                    'Kayıt Ol',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[900],
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Kayıt olarak gizlilik politikamızı kabul etmiş olursunuz.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
