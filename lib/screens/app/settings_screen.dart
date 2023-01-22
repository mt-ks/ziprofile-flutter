import 'package:flutter/material.dart';
import '../welcome_screen.dart';
import '../../utils/shared_prefs.dart';

import 'purchase_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  _navigateToPurchaseScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PurchaseScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Ayarlar'),
      ),
      body: Column(
        children: [
          SettingsItem(
            icon: Icons.upgrade,
            title: 'Aboneliklerim',
            onClick: () {
              _navigateToPurchaseScreen(context);
            },
          ),
          SettingsItem(
            icon: Icons.logout,
            title: 'Çıkış Yap',
            onClick: () async {
              SharedPrefs().userStorage.removeAll();
              SharedPrefs().oauth2Storage.removeAll();
              Navigator.of(context).pushNamedAndRemoveUntil(
                WelcomeScreen.routeName,
                ((route) => false),
              );
            },
          )
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // When the user taps the button, show a snackbar.
      onTap: (() {
        onClick();
      }),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Padding(padding: EdgeInsets.only(right: 12)),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
