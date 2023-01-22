import 'dart:convert';

import '../models/cloud_config.dart';
import 'package:http/http.dart' as http;

class CloudService {
  static const _baseUrl = 'https://webgramb.pro/';

  Future<CloudConfig> getConfig(String service) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}/services?service=${service}'),
      );
      if (response.statusCode == 200) {
        return CloudConfig.fromJson(jsonDecode(response.body));
      }
      print(response.request?.url);
      return throw Exception("Lütfen internet bağlantınızı kontrol edin.");
    } catch (exception) {
      return throw Exception("Lütfen internet bağlantınızı kontrol edin.");
    }
  }
}
