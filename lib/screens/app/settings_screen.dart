import 'package:flutter/material.dart';
import 'package:ziprofile/screens/welcome_screen.dart';
import 'package:ziprofile/utils/shared_prefs.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
            title: 'Premium Ol',
            onClick: () {
              print("prem");
            },
          ),
          SettingsItem(
            icon: Icons.refresh,
            title: 'Aboneliklerimi Geri Yükle',
            onClick: () {
              print("abonel");
            },
          ),
          SettingsItem(
            icon: Icons.logout,
            title: 'Çıkış Yap',
            onClick: () async {
              SharedPrefs().userStorage.removeAll();
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
