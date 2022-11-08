// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_versions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoVersions _$VideoVersionsFromJson(Map<String, dynamic> json) =>
    VideoVersions(
      json['type'] as int?,
      json['height'] as int?,
      json['id'] as String?,
      json['url'] as String?,
      json['width'] as int?,
    );

Map<String, dynamic> _$VideoVersionsToJson(VideoVersions instance) =>
    <String, dynamic>{
      'type': instance.type,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
      'id': instance.id,
    };
