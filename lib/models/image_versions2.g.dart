// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_versions2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageVersions2 _$ImageVersions2FromJson(Map<String, dynamic> json) =>
    ImageVersions2(
      (json['candidates'] as List<dynamic>?)
          ?.map((e) => Candidates.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImageVersions2ToJson(ImageVersions2 instance) =>
    <String, dynamic>{
      'candidates': instance.candidates,
    };
