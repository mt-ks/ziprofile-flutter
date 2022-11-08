import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ziprofile/models/user.dart';
import 'package:ziprofile/services/social_service.dart';
import 'package:ziprofile/utils/shared_prefs.dart';

class ProfileLoaderProvider {
  final ValueChanged<User> onLoadSuccess;
  final ValueChanged<User> onLoadFailed;
  final ValueChanged<User> onOpenNeedSubscription;
  final User user;
  int _loaded = 0;
  ProfileLoaderProvider({
    required this.user,
    required this.onLoadSuccess,
    required this.onLoadFailed,
    required this.onOpenNeedSubscription,
  }) {
    if (user.friendship_status!.is_private &&
        !user.friendship_status!.following) {
      // get from server
    } else {
      _getUserInfo();
      _getStories();
      _getUserFollowing();
      _getPosts();
    }
  }

  void _getUserInfo() async {
    //print(user.pk.toString());
    //  await SocialService().getUserInfoById(user.pk.toString());
  }

  void _getStories() async {
    //var stories = await SocialService().getStories(user.pk);
  }

  void _getUserFollowing() async {
    // await SocialService().getUserFollowing(user.pk);
  }

  void _getPosts() {}

  void _loadedIncrease() {
    _loaded++;
    if (_loaded >= 4) {
      // load completed.
    }
  }
}
