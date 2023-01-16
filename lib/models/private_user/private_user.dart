import 'package:json_annotation/json_annotation.dart';

part 'private_user.g.dart';

@JsonSerializable()
class PrivateUser {
  dynamic checked_at;
  dynamic pk;
  String? username;
  String? full_name;
  String? biography;
  String? profile_picture;
  String? profile_pic_id;
  bool? is_verified;
  bool? is_private;
  int? follower_count;
  int? following_count;
  int? media_count;

  PrivateUser(
    this.checked_at,
    this.pk,
    this.username,
    this.full_name,
    this.biography,
    this.profile_picture,
    this.profile_pic_id,
    this.is_verified,
    this.is_private,
    this.follower_count,
    this.following_count,
    this.media_count,
  );

  factory PrivateUser.fromJson(Map<String, dynamic> json) =>
      _$PrivateUserFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateUserToJson(this);
}
