import 'package:flutter/material.dart';
import '../exceptions/api_exception.dart';
import '../services/api_service.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/scaffold_snackbar.dart';

import '../utils/shared_prefs.dart';
import '../widgets/custom_textfield.dart';
import 'app_screen.dart';

class ResetPasswordConfirmScreen extends StatefulWidget {
  const ResetPasswordConfirmScreen({super.key});
  static const routeName = '/reset-password-confirm';

  @override
  State<ResetPasswordConfirmScreen> createState() =>
      _ResetPasswordConfirmScreenState();
}

class _ResetPasswordConfirmScreenState
    extends State<ResetPasswordConfirmScreen> {
  var verificationCodeController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();

  _verifyAndResetPassword() async {
    var email = ModalRoute.of(context)?.settings.arguments.toString();
    var verificationCode = verificationCodeController.text;
    var password = passwordController.text;
    var rePassword = rePasswordController.text;

    if (email == null) {
      ScaffoldSnackbar(
          context: context, message: 'İsteğiniz ile ilgili bir sorun oluştu!');
      return;
    }
    if (verificationCode.isEmpty || verificationCode.length < 3) {
      ScaffoldSnackbar(
          context: context, message: 'Lütfen geçerli bir onay kodu giriniz!');
      return;
    }

    if (password.length < 6) {
      ScaffoldSnackbar(
          context: context, message: 'Şifreniz en az 6 karakter olmalıdır.');
      return;
    }

    if (password != rePassword) {
      ScaffoldSnackbar(context: context, message: 'Şifreler eşleşmiyor.');
      return;
    }

    var loadingDialog = LoadingDialog(context: context);

    try {
      loadingDialog.showLoaderDialog();
      var resetPassword = await ApiService().confirmResetPassword(
        email,
        password,
        rePassword,
        verificationCode,
      );
      SharedPrefs().oauth2Storage.setOauthToken(resetPassword.token);
      SharedPrefs().oauth2Storage.setCurrentUser(resetPassword);
      loadingDialog.hideDialog();
      _navigateToAppScreen();
    } on APIException catch (e) {
      loadingDialog.hideDialog();
      ScaffoldSnackbar(context: context, message: e.message);
    }
  }

  _navigateToAppScreen() {
    Future.delayed(Duration.zero, () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppScreen.routeName, (r) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Şifreni Sıfırla'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Kodu Onayla',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Size gönderdiğimiz onay kodunu aşağıdaki alana yazın.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: verificationCodeController,
                icon: Icons.code,
                hintText: "Onay Kodu",
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: passwordController,
                icon: Icons.lock,
                hintText: "Yeni Şifre",
                obscureText: true,
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: rePasswordController,
                icon: Icons.lock,
                hintText: "Tekrar Yeni Şifre",
                obscureText: true,
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () => _verifyAndResetPassword(),
                child: Text(
                  'Onayla Ve Şifremi Değiştir',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[900],
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
