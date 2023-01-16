import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ziprofile/models/m2x_response.dart';

class M2XService {
  static const _baseUrl = 'https://m2xcloud.com/';

  Future<M2XResponse> getList() async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}fetch/user/private'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return M2XResponse.fromJson(jsonDecode(response.body));
      }
      throw Exception("Lütfen internet bağlantınızı kontrol edin.");
    } catch (exception) {
      throw Exception("Lütfen internet bağlantınızı kontrol edin.");
    }
  }
}
