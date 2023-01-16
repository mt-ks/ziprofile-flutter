import 'package:json_annotation/json_annotation.dart';

part 'private_following_user.g.dart';

@JsonSerializable()
class PrivateFollowingUser {
  dynamic pk;
  String? username;
  String? full_name;
  bool? is_verified;
  bool? is_private;

  PrivateFollowingUser(
    this.pk,
    this.username,
    this.full_name,
    this.is_verified,
    this.is_private,
  );

  factory PrivateFollowingUser.fromJson(Map<String, dynamic> json) =>
      _$PrivateFollowingUserFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateFollowingUserToJson(this);
}
