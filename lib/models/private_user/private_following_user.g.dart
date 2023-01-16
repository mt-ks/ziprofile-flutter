// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_following_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateFollowingUser _$PrivateFollowingUserFromJson(
        Map<String, dynamic> json) =>
    PrivateFollowingUser(
      json['pk'],
      json['username'] as String?,
      json['full_name'] as String?,
      json['is_verified'] as bool?,
      json['is_private'] as bool?,
    );

Map<String, dynamic> _$PrivateFollowingUserToJson(
        PrivateFollowingUser instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'username': instance.username,
      'full_name': instance.full_name,
      'is_verified': instance.is_verified,
      'is_private': instance.is_private,
    };
