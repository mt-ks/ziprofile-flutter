import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cloud_config.dart';
import '../screens/connection_failed_screen.dart';
import '../screens/app_screen.dart';
import '../screens/welcome_screen.dart';
import '../utils/shared_prefs.dart';

import '../providers/cloud_config_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<CloudConfig?> _getConfig(BuildContext ctx) {
    var provider = Provider.of<CloudConfigProvider>(ctx, listen: false);
    return provider.getConfig();
  }

  void storeConfigAndNavigate(BuildContext ctx, CloudConfig data) {
    SharedPrefs().cloudStorage.setConfig(data);
    String? token = SharedPrefs().userStorage.getBearerToken();
    Future.delayed(Duration.zero, () {
      if (token == null || token == '') {
        Navigator.of(ctx).pushNamedAndRemoveUntil(
          WelcomeScreen.routeName,
          (r) => false,
        );
      } else {
        Navigator.of(ctx).pushNamedAndRemoveUntil(
          AppScreen.routeName,
          (r) => false,
        );
      }
    });
  }

  void errorHandler(BuildContext ctx, Object? error) {
    Future.delayed(Duration.zero, () {
      Navigator.of(ctx).pushNamed(ConnectionFailedScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getConfig(context),
      builder: ((ctx, snapshot) {
        if (snapshot.hasData) {
          storeConfigAndNavigate(ctx, snapshot.data!);
        } else if (snapshot.hasError) {
          errorHandler(ctx, snapshot.error);
        }
        return Scaffold(
          body: Center(
            child: Image.asset(
              "assets/images/app_logo.png",
              width: 50,
            ),
          ),
        );
      }),
    );
  }
}
