import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'current_user.g.dart';

@JsonSerializable()
class CurrentUser {
  CurrentUser(this.user);
  User user;

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}
