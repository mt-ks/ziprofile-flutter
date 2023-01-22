// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth2_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Oauth2User _$Oauth2UserFromJson(Map<String, dynamic> json) => Oauth2User(
      json['uuid'] as String,
      json['email'] as String,
      json['username'] as String,
      json['id'] as int,
    );

Map<String, dynamic> _$Oauth2UserToJson(Oauth2User instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'email': instance.email,
      'username': instance.username,
      'id': instance.id,
    };
