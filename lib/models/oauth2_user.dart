import 'package:json_annotation/json_annotation.dart';
part 'oauth2_user.g.dart';

@JsonSerializable()
class Oauth2User {
  String uuid;
  String email;
  String username;
  int id;

  Oauth2User(this.uuid, this.email, this.username, this.id);

  factory Oauth2User.fromJson(Map<String, dynamic> json) =>
      _$Oauth2UserFromJson(json);

  Map<String, dynamic> toJson() => _$Oauth2UserToJson(this);
}
