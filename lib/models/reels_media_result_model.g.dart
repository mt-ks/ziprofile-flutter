// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reels_media_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReelsMediaResultModel _$ReelsMediaResultModelFromJson(
        Map<String, dynamic> json) =>
    ReelsMediaResultModel(
      (json['reels'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Reel.fromJson(e as Map<String, dynamic>)),
      ),
      json['status'] as String?,
    );

Map<String, dynamic> _$ReelsMediaResultModelToJson(
        ReelsMediaResultModel instance) =>
    <String, dynamic>{
      'reels': instance.reels,
      'status': instance.status,
    };
