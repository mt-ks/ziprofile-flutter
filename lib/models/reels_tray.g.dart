// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reels_tray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReelsTray _$ReelsTrayFromJson(Map<String, dynamic> json) => ReelsTray(
      (json['tray'] as List<dynamic>?)
          ?.map((e) => Tray.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['story_ranking_token'] as String?,
      json['status'] as String?,
    );

Map<String, dynamic> _$ReelsTrayToJson(ReelsTray instance) => <String, dynamic>{
      'tray': instance.tray,
      'story_ranking_token': instance.story_ranking_token,
      'status': instance.status,
    };
