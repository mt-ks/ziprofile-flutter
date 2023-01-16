// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateStory _$PrivateStoryFromJson(Map<String, dynamic> json) => PrivateStory(
      json['taken_at'] as int?,
      json['id'] as String?,
      json['media_type'] as int?,
      json['image_url'] as String?,
      json['video_url'] as String?,
    );

Map<String, dynamic> _$PrivateStoryToJson(PrivateStory instance) =>
    <String, dynamic>{
      'taken_at': instance.taken_at,
      'id': instance.id,
      'media_type': instance.media_type,
      'image_url': instance.image_url,
      'video_url': instance.video_url,
    };
