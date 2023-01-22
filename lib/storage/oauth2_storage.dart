import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/oauth2_register.dart';

class Oauth2Storage {
  Future<Oauth2StorageDB> connect() async {
    var prefs = await SharedPreferences.getInstance();
    return Oauth2StorageDB(prefs);
  }
}

class Oauth2StorageDB {
  final SharedPreferences prefs;
  Oauth2StorageDB(this.prefs);

  void setCurrentUser(Oauth2Register user) {
    prefs.setString("user_info", jsonEncode(user.toJson()));
  }

  Oauth2Register? getCurrentUser() {
    final info = prefs.getString("user_info");
    if (info == null) {
      return null;
    }
    return Oauth2Register.fromJson(jsonDecode(info));
  }

  void setOauthToken(String token) {
    prefs.setString("oauth_token", token);
  }

  String getOauthToken() {
    return prefs.getString('oauth_token') ?? '';
  }

  void removeAll() async {
    await prefs.remove("user_info");
    await prefs.remove("oauth_token");
  }
}
