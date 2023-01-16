// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feeds _$FeedsFromJson(Map<String, dynamic> json) => Feeds(
      (json['items'] as List<dynamic>?)
          ?.map((e) => FeedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as String?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedsToJson(Feeds instance) => <String, dynamic>{
      'items': instance.items,
      'status': instance.status,
      'user': instance.user,
    };
