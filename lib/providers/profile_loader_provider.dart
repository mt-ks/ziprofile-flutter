import 'package:flutter/material.dart';
import '../exceptions/api_exception.dart';
import '../exceptions/social_exception.dart';
import '../models/private_user/private_carousel.dart';
import '../models/private_user/private_following_user.dart';
import '../models/private_user/private_post.dart';
import '../models/private_user/private_user.dart';
import '../models/private_user/private_user_info_response.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/social_service.dart';

import '../models/private_user/private_story.dart';

class ProfileLoaderProvider {
  final ValueChanged<PrivateUserInfoResponse> onLoadSuccess;
  final ValueChanged<String> onLoadFailed;
  final Function onLoginRequired;
  final Function onOpenNeedSubscription;
  final User user;
  int _loaded = 0;

  PrivateUser? _privateUser = null;
  List<PrivatePost> _privatePosts = [];
  List<PrivateStory> _privateStories = [];
  List<PrivateFollowingUser> _privateFollowingUsers = [];

  ProfileLoaderProvider({
    required this.user,
    required this.onLoadSuccess,
    required this.onLoadFailed,
    required this.onLoginRequired,
    required this.onOpenNeedSubscription,
  }) {
    if (user.friendship_status!.is_private! &&
        !user.friendship_status!.following!) {
      _getFromServer();
    } else {
      _getUserInfo();
      _getStories();
      _getUserFollowing();
      _getPosts();
    }
  }

  void _getFromServer() async {
    try {
      var result = await ApiService().getUserInfo(user.pk);
      onLoadSuccess(result);
    } catch (e, stackTrace) {
      customError(e, stackTrace);
    }
  }

  void _getUserInfo() async {
    //print(user.pk.toString());
    try {
      var result = await SocialService().getUserInfoById(user.pk.toString());
      _privateUser = PrivateUser(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        result.user.pk,
        result.user.username,
        result.user.full_name,
        result.user.biography,
        result.user.profile_pic_url,
        result.user.profile_pic_id,
        result.user.is_verified,
        result.user.is_private,
        result.user.follower_count,
        result.user.following_count,
        result.user.media_count,
      );
      _loadedIncrease();
    } catch (e, stackTrace) {
      customError(e, stackTrace);
    }
  }

  void _getStories() async {
    try {
      var stories = await SocialService().getStories(user.pk);
      if (stories.reel?.items != null) {
        var reelList = stories.reel!.items;
        for (var item in reelList) {
          var media_type = item.media_type;
          if (media_type == 1) {
            _privateStories.add(
              PrivateStory(
                item.taken_at,
                item.id,
                media_type,
                item.image_versions2?.candidates?[0].url,
                null,
              ),
            );
          } else {
            _privateStories.add(
              PrivateStory(
                item.taken_at,
                item.id,
                media_type,
                null,
                item.video_versions?[0].url,
              ),
            );
          }
        }
      }
      _loadedIncrease();
    } catch (e, stackTrace) {
      customError(e, stackTrace);
    }
  }

  void _getUserFollowing() async {
    try {
      var following = await SocialService().getUserFollowing(user.pk);
      if (following.users != null) {
        var users = following.users!;
        for (var user in users) {
          _privateFollowingUsers.add(
            PrivateFollowingUser(
              user.pk,
              user.username,
              user.full_name,
              user.is_verified,
              user.is_private,
            ),
          );
        }
      }
      _loadedIncrease();
    } catch (e, stackTrace) {
      customError(e, stackTrace);
    }
  }

  void _getPosts() async {
    try {
      var feeds = await SocialService().getUserFeeds(user.pk);
      if (feeds.items != null) {
        var items = feeds.items!;
        for (var post in items) {
          String caption = post.caption?.text ?? "";
          var taken_at = 0;
          var media_type = post.media_type;
          if (media_type == 1) {
            _privatePosts.add(
              PrivatePost(
                taken_at,
                post.pk,
                post.id,
                media_type,
                post.code,
                post.like_and_view_counts_disabled,
                caption,
                post.like_count,
                null,
                post.image_versions2?.candidates?[0].url,
                null,
              ),
            );
          }
          if (media_type == 8) {
            List<PrivateCarousel> carousel_list = [];
            if (post.carousel_media != null) {
              var carousel_medias = post.carousel_media!;
              for (var carousel_media in carousel_medias) {
                var carousel_type = carousel_media.media_type;
                if (carousel_type == 1) {
                  carousel_list.add(
                    PrivateCarousel(
                      media_type,
                      carousel_media.image_versions2?.candidates?[0].url,
                      null,
                      "NO_PARENT_ID",
                    ),
                  );
                }
              }
            }
            if (carousel_list.length > 0) {
              _privatePosts.add(
                PrivatePost(
                  0,
                  post.pk,
                  post.id,
                  media_type,
                  post.code,
                  post.like_and_view_counts_disabled,
                  caption,
                  post.like_count,
                  carousel_list,
                  null,
                  null,
                ),
              );
            }
          }
        }
      }
      _loadedIncrease();
    } catch (e, stackTrace) {
      customError(e, stackTrace);
    }
  }

  void _loadedIncrease() {
    _loaded++;
    if (_loaded >= 4) {
      onLoadSuccess(
        PrivateUserInfoResponse(
          this._privateUser,
          this._privatePosts,
          this._privateStories,
          null,
          this._privateFollowingUsers,
        ),
      );
    }
  }

  void customError(dynamic e, dynamic stackTrace) {
    if (e is SocialException) {
      if (e.loginRequired) {
        onLoginRequired();
        return;
      }

      onLoadFailed(e.message);
      return;
    }

    if (e is APIException) {
      if (e.loginRequired) {
        onLoginRequired();
        return;
      }

      if (e.errorType == 'need_subscription') {
        onOpenNeedSubscription();
        return;
      }
      onLoadFailed(e.message);
      return;
    }
    onLoadFailed("Beklenmedik bir hata oluştu!");
  }
}
