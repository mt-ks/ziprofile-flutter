// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tray _$TrayFromJson(Map<String, dynamic> json) => Tray(
      json['id'],
      json['latest_reel_media'],
      json['seen'] as int?,
      json['can_reply'] as bool?,
      json['reel_type'] as String?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['story_duration_secs'] as int?,
      json['media_count'] as int?,
      json['media_ids'] as List<dynamic>?,
    );

Map<String, dynamic> _$TrayToJson(Tray instance) => <String, dynamic>{
      'id': instance.id,
      'latest_reel_media': instance.latest_reel_media,
      'seen': instance.seen,
      'can_reply': instance.can_reply,
      'reel_type': instance.reel_type,
      'user': instance.user,
      'story_duration_secs': instance.story_duration_secs,
      'media_count': instance.media_count,
      'media_ids': instance.media_ids,
    };
