// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reels_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReelsItem _$ReelsItemFromJson(Map<String, dynamic> json) => ReelsItem(
      json['taken_at'] as int?,
      json['pk'],
      json['id'] as String?,
      json['media_type'] as int?,
      json['code'] as String?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['image_versions2'] == null
          ? null
          : ImageVersions2.fromJson(
              json['image_versions2'] as Map<String, dynamic>),
      (json['video_versions'] as List<dynamic>?)
          ?.map((e) => VideoVersions.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['has_audio'] as bool?,
      (json['video_duration'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ReelsItemToJson(ReelsItem instance) => <String, dynamic>{
      'taken_at': instance.taken_at,
      'pk': instance.pk,
      'id': instance.id,
      'media_type': instance.media_type,
      'code': instance.code,
      'user': instance.user,
      'image_versions2': instance.image_versions2,
      'video_versions': instance.video_versions,
      'has_audio': instance.has_audio,
      'video_duration': instance.video_duration,
    };
