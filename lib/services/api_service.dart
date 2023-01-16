import 'dart:convert';

import 'package:dio/dio.dart';
import '../exceptions/api_exception.dart';
import '../models/private_user/private_user_info_response.dart';
import '../models/auth_response_model.dart';
import '../storage/user_storage.dart';
import '../utils/shared_prefs.dart';

class ApiService {
  Map<String, String> _defaultHeaders(String oauthToken) {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'x-wg-token': oauthToken
    };
    return headers;
  }

  Future<Dio> _getClient() async {
    var cloudStorage = SharedPrefs().cloudStorage;
    var userStorage = await UserStorage().connect();
    var dio = Dio();
    dio.options.baseUrl = cloudStorage.getConfig()!.service_provider + 'api/';
    dio.options.headers = _defaultHeaders(userStorage.getOauthToken());
    return dio;
  }

  Future<AuthResponseModel> authenticate(
    String? username,
    dynamic userId,
    String? token,
    int? gender, {
    String? csrftoken = null,
    String? useragent = null,
    String? with_bearer = null,
  }) async {
    var client = await _getClient();
    var postData = {
      'username': username,
      'user_id': userId,
      'token': base64.encode(utf8.encode(token!)),
      'gender': gender,
      'csrf_token': csrftoken,
      'useragent': useragent,
      'with_bearer': with_bearer
    };
    try {
      print(client.options.baseUrl);
      var response =
          await client.post(APIEndpoint.authenticate, data: postData);
      return AuthResponseModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        print(e.response?.data);
      }
      throw e;
    }
  }

  Future<PrivateUserInfoResponse> getUserInfo(dynamic user_id) async {
    try {
      var client = await _getClient();
      var response = await client.post(
        APIEndpoint.archive_user,
        data: {'user_id': user_id},
      );
      return PrivateUserInfoResponse.fromJson(response.data);
    } catch (e) {
      throw APIException(e);
    }
  }
}

class APIEndpoint {
  static const authenticate = 'authentication';
  static const archive_user = 'archive/get-user';
}
