import 'dart:collection';
import 'dart:convert';

import '../core/constants.dart';

class BodyPostBuilder {
  final HashMap<String, dynamic> postList = HashMap();

  BodyPostBuilder addPost(String key, dynamic value) {
    postList[key] = value;
    return this;
  }

  String buildForReelsTray(dynamic uid, List<dynamic> userIds) {
    return this
        .addPost('exclude_media_ids', '[]')
        .addPost('supported_capabilities_new', Constants.SCN)
        .addPost('_uid', uid)
        .addPost('user_ids', userIds.toList())
        .build();
  }

  build() {
    var data = jsonEncode(postList);
    return "SIGNATURE.$data";
  }
}
