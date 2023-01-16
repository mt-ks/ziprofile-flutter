import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:ziprofile/core/constants.dart';
import 'package:ziprofile/exceptions/social_exception.dart';
import 'package:ziprofile/models/current_user.dart';
import 'package:ziprofile/models/feeds.dart';
import 'package:ziprofile/models/reels_media_result_model.dart';
import 'package:ziprofile/models/reels_tray.dart';
import 'package:ziprofile/models/search_result_model.dart';
import 'package:ziprofile/models/story_result_model.dart';
import 'package:ziprofile/models/user_following.dart';
import 'package:ziprofile/storage/user_storage.dart';
import 'package:ziprofile/utils/body_post_builder.dart';
import 'package:ziprofile/utils/user_agent_builder.dart';

class SocialService {
  Map<String, String> _defaultHeaders(String userAgent,
      {String? session = null}) {
    Map<String, String> headers = {
      'X-IG-Capabilities': 'AQ==',
      'Accept': '*/*',
      'user-agent': userAgent,
      'X-Ig-App-Locale': 'tr_TR',
      'X-Ig-Device-Locale': 'tr_TR',
      'X-Ig-Mapped-Locale': 'tr_TR',
      'X-Bloks-Is-Layout-Rtl': 'false',
      'X-Bloks-Is-Panorama-Enabled': 'false',
      'X-Ig-Device-Id': '',
      'X-Ig-Family-Device-Id': '',
      'X-Ig-Android-Id': '',
      'X-Ig-Timezone-Offset': '10800',
      'X-Ig-Connection-Type': 'WIFI',
      'X-Ig-Capabilities': '3brTv10=',
      'Accept-Language': 'tr-TR, en-US'
    };
    if (session != null && session.contains("Bearer")) {
      headers["Authorization"] = session;
    }
    if (session != null && session.contains("sessionid")) {
      headers["Cookie"] = session;
    }
    return headers;
  }

  Future<Dio> _getClient() async {
    var userAgent = await UserAgentBuilder().generate();
    var userStorage = await UserStorage().connect();
    var dio = Dio();
    dio.options.baseUrl = SocialEndpoint._baseUrl;
    dio.interceptors.add(SocialServiceInterceptor());
    dio.options.headers = _defaultHeaders(
      userAgent,
      session: userStorage.getBearerToken(),
    );
    return dio;
  }

  Future<CurrentUser> accountsEdit() async {
    try {
      var client = await _getClient();
      var response = await client
          .get(SocialEndpoint.currentUser, queryParameters: {'edit': 'true'});
      return CurrentUser.fromJson(response.data);
    } catch (e, stackTrace) {
      print(e);
      throw SocialException(e);
    }
  }

  Future<SearchResultModel> searchUsers(
    String query, {
    String search_surface = 'user_serp',
  }) async {
    try {
      var client = await _getClient();
      var response = await client.get(SocialEndpoint.search, queryParameters: {
        'search_surface': search_surface,
        'timezone_offset': 0,
        'count': 30,
        'query': query
      });
      return SearchResultModel.fromJson(response.data);
    } catch (e) {
      throw SocialException(e);
    }
  }

  Future<CurrentUser> getUserInfoById(String userId) async {
    try {
      var client = await _getClient();
      var response = await client.get(
        SocialEndpoint.usersInfo(userId),
        queryParameters: {
          'entry_point': 'profile',
          'from_module': 'search_typeahead'
        },
      );
      return CurrentUser.fromJson(response.data);
    } catch (e) {
      throw SocialException(e);
    }
  }

  Future<StoryResultModel> getStories(dynamic userId) async {
    try {
      var client = await _getClient();
      var response = await client.get(
        SocialEndpoint.userStories(userId),
        queryParameters: {
          'supported_capabilities_new': Constants.SCN.toString(),
        },
      );
      return StoryResultModel.fromJson(response.data);
    } catch (e) {
      throw SocialException(e);
    }
  }

  Future<ReelsMediaResultModel> getReelsMedia(uid, List<dynamic> ids) async {
    try {
      var client = await _getClient();
      var signed = BodyPostBuilder().buildForReelsTray(uid, ids);
      var formData = FormData.fromMap({'signed_body': signed});
      var response = await client.post(
        SocialEndpoint.reels_media,
        data: formData,
      );
      return ReelsMediaResultModel.fromJson(response.data);
    } catch (e) {
      print(e);
      if (e is DioError) {
        log(e.response?.data.toString() ?? "");
      }
      throw SocialException(e);
    }
  }

  Future<ReelsTray> getReelsTray() async {
    var client = await _getClient();
    var formData = FormData.fromMap({
      'supported_capabilities_new': Constants.SCN,
      'reason': 'cold_start',
      'timezone_offset': '10800',
      'request_id': '',
      '_uuid': 'af441a51-99d0-433b-83f2-5f98bf13d1bf'
    });
    try {
      var response =
          await client.post(SocialEndpoint.reels_tray, data: formData);
      return ReelsTray.fromJson(response.data);
    } catch (e, stackTrace) {
      print(stackTrace);
      print(e);
      throw SocialException(e);
    }
  }

  Future<UserFollowing> getUserFollowing(dynamic userId) async {
    try {
      var client = await _getClient();
      var response = await client.get(
        SocialEndpoint.userFollowing(userId),
        queryParameters: {
          'includes_hashtags': 'false',
          'search_surface': 'follow_list_page',
          'query': '',
          'enable_groups': 'true',
          'rank_token': Uuid().v1()
        },
      );
      return UserFollowing.fromJson(response.data);
    } catch (e) {
      throw SocialException(e);
    }
  }

  Future<void> getWebUserInfo(String username) async {
    try {
      var client = await _getClient();
      var response = await client.get(
        SocialEndpoint.web_profile_info,
        queryParameters: {'username': username},
      );
      print(response);
    } catch (e) {
      throw SocialException(e);
    }
  }

  Future<Feeds> getUserFeeds(dynamic userId) async {
    try {
      var client = await _getClient();
      var response = await client.get(SocialEndpoint.userFeeds(userId));
      return Feeds.fromJson(response.data);
    } catch (e) {
      throw SocialException(e);
    }
  }
}

class SocialEndpoint {
  static const _baseUrl = 'https://i.instagram.com/api/v1/';
  static const currentUser = 'accounts/current_user/';
  static const search = 'fbsearch/account_serp/';
  static const reels_media = 'feed/reels_media/';
  static const reels_tray = 'feed/reels_tray/';
  static const web_profile_info = 'users/web_profile_info/';
  static String userFeeds(dynamic userId) =>
      'feed/user/${userId}/?exclude_comment=true&only_fetch_first_carousel_media=false&count=20';
  static String usersInfo(String userId) => 'users/${userId}/info/';
  static String userStories(dynamic userId) => 'feed/user/${userId}/story/';
  static String userFollowing(dynamic userId) =>
      'friendships/${userId}/following/';
}

class SocialServiceInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    UserStorageDB userStorage = (await UserStorage().connect());
    String? bearerToken = response.headers.value("ig-set-authorization");
    if (bearerToken != null) {
      userStorage.setBearerToken(bearerToken);
    }
    super.onResponse(response, handler);
  }
}
