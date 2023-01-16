// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Caption _$CaptionFromJson(Map<String, dynamic> json) => Caption(
      json['pk'],
      json['text'] as String?,
      json['type'] as int?,
    );

Map<String, dynamic> _$CaptionToJson(Caption instance) => <String, dynamic>{
      'text': instance.text,
      'pk': instance.pk,
      'type': instance.type,
    };
