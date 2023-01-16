// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedItem _$FeedItemFromJson(Map<String, dynamic> json) => FeedItem(
      json['taken_at'],
      json['pk'],
      json['id'] as String?,
      json['media_type'] as int?,
      json['code'] as String?,
      json['like_and_view_counts_disabled'] as bool?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['like_count'] as int?,
      json['has_liked'] as bool?,
      json['image_versions2'] == null
          ? null
          : ImageVersions2.fromJson(
              json['image_versions2'] as Map<String, dynamic>),
      (json['video_versions'] as List<dynamic>?)
          ?.map((e) => VideoVersions.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['view_count'] as int?,
      json['play_count'] as int?,
      json['caption'] == null
          ? null
          : Caption.fromJson(json['caption'] as Map<String, dynamic>),
      (json['carousel_media'] as List<dynamic>?)
          ?.map((e) => CarouselMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedItemToJson(FeedItem instance) => <String, dynamic>{
      'taken_at': instance.taken_at,
      'pk': instance.pk,
      'id': instance.id,
      'media_type': instance.media_type,
      'code': instance.code,
      'like_and_view_counts_disabled': instance.like_and_view_counts_disabled,
      'user': instance.user,
      'like_count': instance.like_count,
      'has_liked': instance.has_liked,
      'image_versions2': instance.image_versions2,
      'caption': instance.caption,
      'video_versions': instance.video_versions,
      'carousel_media': instance.carousel_media,
      'view_count': instance.view_count,
      'play_count': instance.play_count,
    };
