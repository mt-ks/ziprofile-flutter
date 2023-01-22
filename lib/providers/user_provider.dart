import 'package:flutter/material.dart';
import '../models/oauth2_register.dart';
import '../utils/shared_prefs.dart';

class UserProvider with ChangeNotifier {
  Oauth2Register? get user {
    var currentUser = SharedPrefs().oauth2Storage.getCurrentUser();
    return currentUser;
  }
}
