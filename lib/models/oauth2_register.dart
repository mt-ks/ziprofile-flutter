import 'package:ziprofile/models/oauth2_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'oauth2_register.g.dart';

@JsonSerializable()
class Oauth2Register {
  String status;
  String message;
  Oauth2User user;
  String token;

  Oauth2Register(this.status, this.message, this.user, this.token);

  factory Oauth2Register.fromJson(Map<String, dynamic> json) =>
      _$Oauth2RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$Oauth2RegisterToJson(this);
}
