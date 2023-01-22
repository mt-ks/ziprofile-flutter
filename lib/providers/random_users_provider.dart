import 'package:flutter/material.dart';
import '../models/search_users_response.dart';
import '../services/api_service.dart';

class RandomUsersProvider extends ChangeNotifier {
  SearchUsersResponse? randomUsers;
  RandomUsersProvider() {
    _getRandomUsers();
  }

  _getRandomUsers() async {
    try {
      randomUsers = await ApiService().randomUsers();
      notifyListeners();
    } catch (e) {}
  }
}
