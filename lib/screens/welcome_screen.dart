import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Navigator.of(context).pushNamed(AuthScreen.routeName, arguments: config);
  }

  _test() async {}

  @override
  Widget build(BuildContext context) {
    _test();
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
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
              'Gizli profilleri arşivle & görüntüle',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => _routeToAuthScreen(context),
            child: Text('Oturum Aç'),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 24, 24, 24)),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
