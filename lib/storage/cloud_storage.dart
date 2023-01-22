import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/cloud_config.dart';

class CloudStorageDB {
  final SharedPreferences prefs;
  CloudStorageDB(this.prefs);

  void setConfig(CloudConfig cloudConfig) {
    final jsonString = jsonEncode(cloudConfig.toJson());
    prefs.setString("z_app_config", jsonString);
  }

  CloudConfig? getConfig() {
    final String? configString = prefs.getString("z_app_config");
    if (configString == null) {
      return null;
    }
    final decode = jsonDecode(configString);
    return CloudConfig.fromJson(decode);
  }
}
