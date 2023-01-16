import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/private_user/private_following_user.dart';
import 'package:ziprofile/models/private_user/private_highlight.dart';
import 'package:ziprofile/models/private_user/private_post.dart';
import 'package:ziprofile/models/private_user/private_story.dart';
import 'package:ziprofile/models/private_user/private_user.dart';

part 'private_user_info_response.g.dart';

@JsonSerializable()
class PrivateUserInfoResponse {
  PrivateUser? info;
  List<PrivatePost>? posts;
  List<PrivateStory>? stories;
  List<PrivateHighlight>? highlights;
  List<PrivateFollowingUser>? following;
  PrivateUserInfoResponse(
    this.info,
    this.posts,
    this.stories,
    this.highlights,
    this.following,
  );

  factory PrivateUserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$PrivateUserInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateUserInfoResponseToJson(this);
}
