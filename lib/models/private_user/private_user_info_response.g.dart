// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_user_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateUserInfoResponse _$PrivateUserInfoResponseFromJson(
        Map<String, dynamic> json) =>
    PrivateUserInfoResponse(
      json['info'] == null
          ? null
          : PrivateUser.fromJson(json['info'] as Map<String, dynamic>),
      (json['posts'] as List<dynamic>?)
          ?.map((e) => PrivatePost.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['stories'] as List<dynamic>?)
          ?.map((e) => PrivateStory.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['highlights'] as List<dynamic>?)
          ?.map((e) => PrivateHighlight.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['following'] as List<dynamic>?)
          ?.map((e) => PrivateFollowingUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrivateUserInfoResponseToJson(
        PrivateUserInfoResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
      'posts': instance.posts,
      'stories': instance.stories,
      'highlights': instance.highlights,
      'following': instance.following,
    };
