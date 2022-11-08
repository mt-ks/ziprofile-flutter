// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['pk'],
      json['username'] as String?,
      json['full_name'] as String?,
      json['is_private'] as bool?,
      json['profile_pic_url'] as String?,
      json['profile_pic_id'] as String?,
      json['is_verified'] as bool?,
      json['has_anonymous_profile_picture'] as bool?,
      json['biography'] as String?,
      json['external_url'] as String?,
      json['friendship_status'] == null
          ? null
          : FriendsipStatus.fromJson(
              json['friendship_status'] as Map<String, dynamic>),
      json['follower_count'] as int?,
      json['following_count'] as int?,
      json['media_count'] as int?,
    )
      ..gender = json['gender'] as int?
      ..phone_number = json['phone_number'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'pk': instance.pk,
      'username': instance.username,
      'full_name': instance.full_name,
      'is_private': instance.is_private,
      'profile_pic_url': instance.profile_pic_url,
      'profile_pic_id': instance.profile_pic_id,
      'is_verified': instance.is_verified,
      'has_anonymous_profile_picture': instance.has_anonymous_profile_picture,
      'biography': instance.biography,
      'external_url': instance.external_url,
      'gender': instance.gender,
      'phone_number': instance.phone_number,
      'friendship_status': instance.friendship_status,
      'follower_count': instance.follower_count,
      'following_count': instance.following_count,
      'media_count': instance.media_count,
    };
