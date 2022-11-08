// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendsipStatus _$FriendsipStatusFromJson(Map<String, dynamic> json) =>
    FriendsipStatus(
      json['following'] as bool,
      json['is_private'] as bool,
      json['incoming_request'] as bool,
      json['outgoing_request'] as bool,
      json['is_bestie'] as bool,
      json['is_feed_favorite'] as bool,
      json['is_restricted'] as bool,
    );

Map<String, dynamic> _$FriendsipStatusToJson(FriendsipStatus instance) =>
    <String, dynamic>{
      'following': instance.following,
      'is_private': instance.is_private,
      'incoming_request': instance.incoming_request,
      'outgoing_request': instance.outgoing_request,
      'is_bestie': instance.is_bestie,
      'is_restricted': instance.is_restricted,
      'is_feed_favorite': instance.is_feed_favorite,
    };
