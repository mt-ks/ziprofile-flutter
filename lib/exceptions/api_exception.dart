import 'package:dio/dio.dart';

class APIException implements Exception {
  String message = "Beklenmedi bir hata oluştu!";
  bool loginRequired = false;
  dynamic responseData = null;
  dynamic errorType = null;
  dynamic errorTitle = null;
  dynamic errorDescription = null;

  APIException(Object error) {
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

    errorType = e.response?.data['error_type'];
    errorTitle = e.response?.data['error_title'];
    errorDescription = e.response?.data['error_description'];

    if (responseMessage == "bad_auth") {
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
