import 'package:flutter/material.dart';
import '../exceptions/api_exception.dart';
import '../screens/reset_password_confirm_screen.dart';
import '../services/api_service.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/scaffold_snackbar.dart';

import '../widgets/custom_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const routeName = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var emailController = TextEditingController();

  _sendVerificationCode() async {
    var loadingDialog = LoadingDialog(context: context);
    var email = emailController.text;
    if (email.isEmpty || !email.contains("@") || email.length < 4) {
      ScaffoldSnackbar(
        context: context,
        message: 'Lütfen geçerli bir e-posta adresi girin.',
      );
      return;
    }
    try {
      loadingDialog.showLoaderDialog();
      var response = await ApiService().sendResetPasswordCode(email);
      ScaffoldSnackbar(context: context, message: response.message);
      loadingDialog.hideDialog();

      Navigator.of(context).pushNamed(
        ResetPasswordConfirmScreen.routeName,
        arguments: email,
      );
    } on APIException catch (e) {
      loadingDialog.hideDialog();
      ScaffoldSnackbar(context: context, message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Şifremi Unuttum'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Şifreni Sıfırla',
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
                'Hesabın size ait olduğunu doğrulamak için bir e-posta göndereceğiz.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: emailController,
                icon: Icons.email_outlined,
                hintText: "E-Posta adresiniz",
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => _sendVerificationCode(),
                child: Text(
                  'Onay Kodu Gönder',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[900],
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
