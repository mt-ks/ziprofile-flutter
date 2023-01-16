// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivatePost _$PrivatePostFromJson(Map<String, dynamic> json) => PrivatePost(
      json['taken_at'] as int?,
      json['pk'],
      json['id'] as String?,
      json['media_type'] as int?,
      json['code'] as String?,
      json['like_and_view_counts_disabled'] as bool?,
      json['caption'] as String?,
      json['like_count'] as int?,
      (json['carousel_media'] as List<dynamic>?)
          ?.map((e) => PrivateCarousel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['image_url'] as String?,
      json['video_url'] as String?,
    );

Map<String, dynamic> _$PrivatePostToJson(PrivatePost instance) =>
    <String, dynamic>{
      'taken_at': instance.taken_at,
      'pk': instance.pk,
      'id': instance.id,
      'media_type': instance.media_type,
      'code': instance.code,
      'like_and_view_counts_disabled': instance.like_and_view_counts_disabled,
      'caption': instance.caption,
      'like_count': instance.like_count,
      'carousel_media': instance.carousel_media,
      'image_url': instance.image_url,
      'video_url': instance.video_url,
    };
