import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/friendship_status.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  dynamic pk;
  String? username;
  String? full_name;
  bool? is_private;
  String? profile_pic_url;
  String? profile_pic_id;
  bool? is_verified;
  bool? has_anonymous_profile_picture;
  String? biography;
  String? external_url;

  int? gender;
  String? phone_number;

  FriendsipStatus? friendship_status;
  int? follower_count;
  int? following_count;
  int? media_count;

  User(
    this.pk,
    this.username,
    this.full_name,
    this.is_private,
    this.profile_pic_url,
    this.profile_pic_id,
    this.is_verified,
    this.has_anonymous_profile_picture,
    this.biography,
    this.external_url,
    this.friendship_status,
    this.follower_count,
    this.following_count,
    this.media_count,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
