import 'package:flutter/material.dart';
import 'package:ziprofile/models/search_result_model.dart';
import 'package:ziprofile/services/social_service.dart';

class SearchProvider extends ChangeNotifier {
  SearchResultModel? searchResult;

  searchUsers(String query) async {
    try {
      searchResult = await SocialService().searchUsers(query);
      print(searchResult?.users.length);
      notifyListeners();
    } catch (e) {}
  }
}
