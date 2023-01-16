import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziprofile/models/m2x_response.dart';

import '../models/user.dart';

class UserStorage {
  Future<UserStorageDB> connect() async {
    var prefs = await SharedPreferences.getInstance();
    return UserStorageDB(prefs);
  }
}

class UserStorageDB {
  final SharedPreferences prefs;
  UserStorageDB(this.prefs);

  String? getUsername() {
    return prefs.getString('username');
  }

  void setUsername(String username) {
    prefs.setString("username", username);
  }

  void setBearerToken(String token) {
    prefs.setString("bearer_token", token);
  }

  String? getBearerToken() {
    return prefs.getString("bearer_token");
  }

  void setOauthToken(String token) {
    prefs.setString("oauth_token", token);
  }

  String getOauthToken() {
    return prefs.getString('oauth_token') ?? '';
  }

  void setCurrentUser(User user) {
    prefs.setString("user_info", jsonEncode(user.toJson()));
  }

  User? getCurrentUser() {
    final info = prefs.getString("user_info");
    if (info == null) {
      return null;
    }
    return User.fromJson(jsonDecode(info));
  }

  void setM2XUserList(M2XResponse response) {
    prefs.setString("m2x_user_list", jsonEncode(response.toJson()));
  }

  M2XResponse? getM2XUserList() {
    final response = prefs.getString("m2x_user_list");
    if (response == null) {
      return null;
    }
    return M2XResponse.fromJson(jsonDecode(response));
  }

  void setIsFastAuth(bool isFastAuth) {
    prefs.setBool("is_fast_auth", isFastAuth);
  }

  bool getIsFastAuth() {
    return prefs.getBool("is_fast_auth") ?? false;
  }

  void removeAll() async {
    await prefs.remove("username");
    await prefs.remove("bearer_token");
    await prefs.remove("oauth_token");
    await prefs.remove("user_info");
    await prefs.remove("is_fast_auth");
    await prefs.remove("m2x_user_list");
  }
}
