// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateUser _$PrivateUserFromJson(Map<String, dynamic> json) => PrivateUser(
      json['checked_at'],
      json['pk'],
      json['username'] as String?,
      json['full_name'] as String?,
      json['biography'] as String?,
      json['profile_picture'] as String?,
      json['profile_pic_id'] as String?,
      json['is_verified'] as bool?,
      json['is_private'] as bool?,
      json['follower_count'] as int?,
      json['following_count'] as int?,
      json['media_count'] as int?,
    );

Map<String, dynamic> _$PrivateUserToJson(PrivateUser instance) =>
    <String, dynamic>{
      'checked_at': instance.checked_at,
      'pk': instance.pk,
      'username': instance.username,
      'full_name': instance.full_name,
      'biography': instance.biography,
      'profile_picture': instance.profile_picture,
      'profile_pic_id': instance.profile_pic_id,
      'is_verified': instance.is_verified,
      'is_private': instance.is_private,
      'follower_count': instance.follower_count,
      'following_count': instance.following_count,
      'media_count': instance.media_count,
    };
