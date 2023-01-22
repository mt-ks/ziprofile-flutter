import 'package:dio/dio.dart';
import '../models/generic_response.dart';
import '../models/oauth2_register.dart';
import '../models/search_users_response.dart';
import '../models/user_subscriptions_response.dart';
import '../exceptions/api_exception.dart';
import '../models/private_user/private_user_info_response.dart';
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
    var oaut2hStorage = SharedPrefs().oauth2Storage;
    var dio = Dio();
    dio.options.baseUrl = cloudStorage.getConfig()!.service_provider + 'api/';
    dio.options.headers = _defaultHeaders(oaut2hStorage.getOauthToken());
    return dio;
  }

  Future<Oauth2Register> login(String email, String password) async {
    try {
      var client = await _getClient();
      var response = await client.post(APIEndpoint.login, data: {
        'email': email,
        'password': password,
      });
      return Oauth2Register.fromJson(response.data);
    } catch (e) {
      throw APIException(e);
    }
  }

  Future<Oauth2Register> register(
    String email,
    String username,
    String password,
    String rePassword,
    int gender,
  ) async {
    try {
      var client = await _getClient();
      var response = await client.post(APIEndpoint.register, data: {
        'email': email,
        'username': username,
        'password': password,
        're_password': rePassword,
        'gender': gender,
      });
      return Oauth2Register.fromJson(response.data);
    } catch (e) {
      throw APIException(e);
    }
  }

  Future<SearchUsersResponse> searchUsers(String username) async {
    try {
      var client = await _getClient();
      var response = await client
          .post(APIEndpoint.searchUser, data: {'username': username});
      return SearchUsersResponse.fromJson(response.data);
    } catch (e) {
      throw APIException(e);
    }
  }

  Future<SearchUsersResponse> randomUsers() async {
    try {
      var client = await _getClient();
      var response = await client.get(APIEndpoint.randomUsers);
      return SearchUsersResponse.fromJson(response.data);
    } catch (e) {
      throw APIException(e);
    }
  }

  Future<PrivateUserInfoResponse> getUserInfo(
    dynamic user_id, {
    String? access_token = null,
  }) async {
    try {
      var client = await _getClient();
      var response = await client.post(
        APIEndpoint.userInfo,
        data: {
          'user_id': user_id,
          'access_token': access_token,
        },
      );
      return PrivateUserInfoResponse.fromJson(response.data);
    } catch (e) {
      throw APIException(e);
    }
  }

  Future<void> restorePurchases(String receiptData) async {
    try {
      var client = await _getClient();
      var response = await client.post(APIEndpoint.restorePurchase, data: {
        'receipt-data': receiptData,
      });
      print(response.data);
    } catch (e) {
      throw APIException(e);
    }
  }

  Future<UserSubscriptionsResponse> getActiveSubscriptions() async {
    try {
      var client = await _getClient();
      var response = await client.get(APIEndpoint.activePurchases);
      print(response.data);
      return UserSubscriptionsResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      throw APIException(e);
    }
  }

  Future<GenericResponse> sendResetPasswordCode(String email) async {
    try {
      var client = await _getClient();
      var response =
          await client.post(APIEndpoint.sendResetPasswordCode, data: {
        'email': email,
      });
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      throw APIException(e);
    }
  }

  Future<Oauth2Register> confirmResetPassword(String email, String password,
      String rePassword, String verificationCode) async {
    try {
      var client = await _getClient();
      var response =
          await client.post(APIEndpoint.confirmResetPasswordCode, data: {
        'email': email,
        'password': password,
        're_password': rePassword,
        'verification_code': verificationCode
      });
      return Oauth2Register.fromJson(response.data);
    } catch (e) {
      print(e);
      throw APIException(e);
    }
  }
}

class APIEndpoint {
  static const login = 'oauth2/login';
  static const register = 'oauth2/register';
  static const sendResetPasswordCode = 'oauth2/reset-password';
  static const confirmResetPasswordCode = 'oauth2/reset-password-confirm';
  static const searchUser = 'search-users';
  static const userInfo = 'search-users/detail';
  static const randomUsers = 'search-users/random';
  static const restorePurchase = 'apple-restore';
  static const activePurchases = 'iap/active-subscriptions';
}
