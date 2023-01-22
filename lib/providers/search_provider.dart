import 'package:flutter/material.dart';
import 'package:ziprofile/models/search_users_response.dart';

import '../services/api_service.dart';

class SearchProvider extends ChangeNotifier {
  SearchUsersResponse? searchResponse;

  searchUsers(String query) async {
    try {
      searchResponse = await ApiService().searchUsers(query);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
