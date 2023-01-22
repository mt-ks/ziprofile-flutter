import 'package:flutter/material.dart';
import '../services/social_service.dart';
import '../utils/shared_prefs.dart';

import '../models/reel.dart';

class StoryProvider with ChangeNotifier {
  List<Reel>? stored_reels = null;
  StoryProvider() {
    var isFastAuth = SharedPrefs().userStorage.getIsFastAuth();
    if (stored_reels == null && !isFastAuth) {
      this.getReelsTray();
    }
  }
  Future<void> getReelsTray() async {
    print("Request handled");
    stored_reels = [];
    try {
      var reels_tray = await SocialService().getReelsTray();
      List<dynamic> user_ids = [];
      for (var tray in reels_tray.tray!) {
        user_ids.add(tray.user?.pk);
      }
      var chunked_ids = _chunkItems(user_ids);
      for (List<dynamic> group_id in chunked_ids) {
        _getReelsMedia(group_id);
      }
    } catch (e) {
      print(e);
    }
  }

  _getReelsMedia(List<dynamic> user_ids) async {
    var uid = SharedPrefs().userStorage.getCurrentUser()!.pk;
    try {
      var items = await SocialService().getReelsMedia(uid, user_ids);
      for (var key in items.reels.keys) {
        stored_reels!.add(items.reels[key]!);
      }
      notifyListeners();
    } catch (e, stackTrace) {
      print(stackTrace);
      print(e);
    }
  }

  _chunkItems(List<dynamic> list) {
    var chunks = [];
    int chunkSize = 5;
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(
          i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }
}
