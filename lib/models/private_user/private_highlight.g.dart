// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_highlight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateHighlight _$PrivateHighlightFromJson(Map<String, dynamic> json) =>
    PrivateHighlight(
      json['id'],
      json['title'] as String?,
      json['created_at'],
      json['media_count'] as int?,
      json['cover_media'] as String?,
      (json['items'] as List<dynamic>?)
          ?.map((e) => PrivateHighlightItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrivateHighlightToJson(PrivateHighlight instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'created_at': instance.created_at,
      'media_count': instance.media_count,
      'cover_media': instance.cover_media,
      'items': instance.items,
    };
