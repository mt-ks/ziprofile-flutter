import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ziprofile/utils/shared_prefs.dart';

import '../screens/app_screen.dart';
import '../services/api_service.dart';
import '../widgets/loading_dialog.dart';
import '../models/user.dart';
import '../services/social_service.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isAuthenticated = false;
  bool _isAuthenticationFlow = false;
  late LoadingDialog loadingDialog;

  @override
  void initState() {
    loadingDialog = LoadingDialog(context: context);
    super.initState();
  }

  void setFlowState(bool flow) {
    setState(() {
      _isAuthenticationFlow = flow;
    });
  }

  void storeUserWithToken(String token) async {
    SharedPrefs().userStorage.setBearerToken(token);
    _getAccountsEdit(token);
  }

  void storeUserWithCookie(List<Cookie> cookies) async {
    var _cookieString = '';
    for (var cookie in cookies) {
      _cookieString += '${cookie.name}=${cookie.value}; ';
    }
    SharedPrefs().userStorage.setBearerToken(_cookieString);
    _getAccountsEdit(_cookieString);
  }

  _getAccountsEdit(String? firstAuthToken) async {
    setFlowState(true);
    loadingDialog.showLoaderDialog();
    try {
      var user = await SocialService().accountsEdit();
      _authSuccess(user.user, firstAuthToken);
    } catch (e) {
      _errorHandler(e);
    }
  }

  _authSuccess(User user, String? firstAuthToken) async {
    try {
      var authenticate = await ApiService().authenticate(
        user.username,
        user.pk,
        firstAuthToken,
        user.gender,
        with_bearer: SharedPrefs().userStorage.getBearerToken(),
      );
      // Store oauth token
      SharedPrefs().userStorage.setOauthToken(authenticate.oauth_token);
      SharedPrefs().userStorage.setCurrentUser(user);
      loadingDialog.hideDialog();
      setState(() {
        _isAuthenticated = true;
      });
    } catch (e) {
      _errorHandler(e);
    }
  }

  _navigateListener() {
    if (_isAuthenticated) {
      print("Authenticated");
      Future.delayed(Duration.zero, () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppScreen.routeName, (r) => false);
      });
    }
  }

  _errorHandler(var err) {
    print(err);
    setFlowState(false);
    loadingDialog.hideDialog();
  }

  @override
  Widget build(BuildContext context) {
    _navigateListener();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Oturum Aç',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: _isAuthenticationFlow
            ? Center(
                child: Text(
                  'Giriş yapılıyor...',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : WebView(
                onPageStarted: (url) {
                  loadingDialog.showLoaderDialog();
                },
                onPageFinished: (url) async {
                  loadingDialog.hideDialog();
                  final cookieManager = WebviewCookieManager();
                  final gotCookies = await cookieManager.getCookies(url);
                  for (var item in gotCookies) {
                    if (item.name == 'auth_bearer_wg' && item.value != '') {
                      storeUserWithToken(item.value);
                    }
                    if (item.name == 'ds_user_id') {
                      storeUserWithCookie(gotCookies);
                    }
                  }
                },
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: "https://www.instagram.com/accounts/login",
              ),
      ),
    );
  }
}
