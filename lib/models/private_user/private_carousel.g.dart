// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_carousel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateCarousel _$PrivateCarouselFromJson(Map<String, dynamic> json) =>
    PrivateCarousel(
      json['media_type'] as int?,
      json['image_url'] as String?,
      json['video_url'] as String?,
      json['carousel_parent_id'] as String?,
    );

Map<String, dynamic> _$PrivateCarouselToJson(PrivateCarousel instance) =>
    <String, dynamic>{
      'media_type': instance.media_type,
      'image_url': instance.image_url,
      'video_url': instance.video_url,
      'carousel_parent_id': instance.carousel_parent_id,
    };
