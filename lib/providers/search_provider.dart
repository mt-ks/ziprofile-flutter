import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ziprofile/exceptions/social_exception.dart';
import 'package:ziprofile/models/m2x_response.dart';
import 'package:ziprofile/models/search_result_model.dart';
import 'package:ziprofile/services/m2x_service.dart';
import 'package:ziprofile/services/social_service.dart';
import 'package:ziprofile/utils/shared_prefs.dart';

class SearchProvider extends ChangeNotifier {
  SearchResultModel? searchResult;

  searchUsers(String query) async {
    try {
      searchResult = await SocialService().searchUsers(query);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  M2XResponse? get m2xResponse {
    return SharedPrefs().userStorage.getM2XUserList();
  }
}
