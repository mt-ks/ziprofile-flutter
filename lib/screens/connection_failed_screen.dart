import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/shared_prefs.dart';
import '../models/cloud_config.dart';
import '../screens/welcome_screen.dart';
import '../providers/cloud_config_provider.dart';
import '../widgets/loading_dialog.dart';

class ConnectionFailedScreen extends StatelessWidget {
  static const routeName = '/connection-failed';
  const ConnectionFailedScreen({super.key});

  void storeConfigAndNavigate(BuildContext ctx, CloudConfig data) {
    SharedPrefs().cloudStorage.setConfig(data);
    Navigator.of(ctx).popAndPushNamed(WelcomeScreen.routeName);
  }

  void checkConnection(BuildContext ctx) {
    var loading = LoadingDialog(context: ctx);
    loading.showLoaderDialog();

    var provider = Provider.of<CloudConfigProvider>(ctx, listen: false);
    provider.getConfig().then((value) {
      loading.hideDialog();
      storeConfigAndNavigate(ctx, value!);
    }).catchError((err) {
      loading.hideDialog();
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text("Lütfen internet bağlantınızı kontrol edin."),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Connection error',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Text(
                'Bir bağlantı sorunu oluştu, internetini kontrol et ve tekrar dene!',
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () => checkConnection(context),
              child: Text('Tekrar Dene'),
            )
          ],
        ),
      ),
    );
  }
}
