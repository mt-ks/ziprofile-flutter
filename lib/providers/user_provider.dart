import 'package:flutter/material.dart';
import 'package:ziprofile/utils/shared_prefs.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? get user {
    return SharedPrefs().userStorage.getCurrentUser();
  }
}
