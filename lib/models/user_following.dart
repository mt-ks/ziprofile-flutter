import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/user.dart';

part 'user_following.g.dart';

@JsonSerializable()
class UserFollowing {
  List<User>? users;

  UserFollowing(this.users);

  factory UserFollowing.fromJson(Map<String, dynamic> json) =>
      _$UserFollowingFromJson(json);

  Map<String, dynamic> toJson() => _$UserFollowingToJson(this);
}
