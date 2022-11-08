// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryResultModel _$StoryResultModelFromJson(Map<String, dynamic> json) =>
    StoryResultModel(
      json['reel'] == null
          ? null
          : Reel.fromJson(json['reel'] as Map<String, dynamic>),
    )..status = json['status'] as String?;

Map<String, dynamic> _$StoryResultModelToJson(StoryResultModel instance) =>
    <String, dynamic>{
      'reel': instance.reel,
      'status': instance.status,
    };
