import 'dart:io';

class NetworkConnectivity {
  static Future<bool> checkConnection() async {
    final hasInternet = await checkLookup();
    return hasInternet;
  }

  static Future<bool> checkLookup() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {}
    return false;
  }
}
