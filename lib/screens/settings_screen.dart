import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cloud_config_provider.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CloudConfigProvider>(context, listen: false);
    print("Generated settings screen");
    return Scaffold(
      appBar: AppBar(
        title: Text(provider.config!.service_address),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              provider.getConfig();
            },
            child: Text('New Request')),
      ),
    );
  }
}
