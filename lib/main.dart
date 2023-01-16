import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziprofile/providers/search_provider.dart';
import 'package:ziprofile/providers/story_provider.dart';
import 'package:ziprofile/screens/auth_without_credentials.dart';
import 'package:ziprofile/screens/signin_screen.dart';
import './utils/shared_prefs.dart';

import './providers/user_provider.dart';
import './providers/cloud_config_provider.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen.dart';
import './screens/connection_failed_screen.dart';
import './screens/settings_screen.dart';
import './screens/app_screen.dart';
import './screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CloudConfigProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => SearchProvider()),
        ChangeNotifierProvider(create: (ctx) => StoryProvider()),
      ],
      child: MaterialApp(
        title: 'ZIPROFILE',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: '.SF Pro Text',
            scaffoldBackgroundColor: Color.fromARGB(0, 0, 0, 0)),
        home: SplashScreen(),
        routes: {
          WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
          SettingScreen.routeName: (ctx) => SettingScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          SignInScreen.routeName: (ctx) => SignInScreen(),
          ConnectionFailedScreen.routeName: (ctx) => ConnectionFailedScreen(),
          AppScreen.routeName: (ctx) => AppScreen(),
          AuthWithoutCredentialsScreen.routeName: (ctx) =>
              AuthWithoutCredentialsScreen()
        },
      ),
    );
  }
}
