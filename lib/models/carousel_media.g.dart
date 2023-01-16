// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselMedia _$CarouselMediaFromJson(Map<String, dynamic> json) =>
    CarouselMedia(
      json['id'],
      json['media_type'] as int?,
      json['image_versions2'] == null
          ? null
          : ImageVersions2.fromJson(
              json['image_versions2'] as Map<String, dynamic>),
      json['carousel_parent_id'],
    );

Map<String, dynamic> _$CarouselMediaToJson(CarouselMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_type': instance.media_type,
      'image_versions2': instance.image_versions2,
      'carousel_parent_id': instance.carousel_parent_id,
    };
