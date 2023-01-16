import 'package:dio/dio.dart';

class SocialException implements Exception {
  String message = "Beklenmedi bir hata oluştu!";
  bool loginRequired = false;
  dynamic responseData = null;
  SocialException(Object error) {
    if (error is DioError) {
      _fetchMessage(error);
    }
  }

  _fetchMessage(DioError e) {
    if (e.response == null) {
      return;
    }

    this.responseData = e.response!.data;
    var responseMessage = e.response!.data["message"];
    if (responseMessage == "challenge_required" ||
        responseMessage == "checkpoint_required") {
      this.message =
          "Bir sorun oluştu! IG Uygulaması üzerinden hesabınızı doğrulamanız gerekiyor.";
      return;
    }
    if (responseMessage == "login_required") {
      loginRequired = true;
      this.message == "Oturumunuz sona erdi";
      return;
    }

    if (responseMessage != null) {
      this.message = responseMessage;
    }
  }

  @override
  String toString() {
    return this.message;
  }
}
