// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth2_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Oauth2Register _$Oauth2RegisterFromJson(Map<String, dynamic> json) =>
    Oauth2Register(
      json['status'] as String,
      json['message'] as String,
      Oauth2User.fromJson(json['user'] as Map<String, dynamic>),
      json['token'] as String,
    );

Map<String, dynamic> _$Oauth2RegisterToJson(Oauth2Register instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'user': instance.user,
      'token': instance.token,
    };
