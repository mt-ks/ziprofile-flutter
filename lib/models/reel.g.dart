// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reel _$ReelFromJson(Map<String, dynamic> json) => Reel(
      json['id'],
      User.fromJson(json['user'] as Map<String, dynamic>),
      (json['items'] as List<dynamic>)
          .map((e) => ReelsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReelToJson(Reel instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'items': instance.items,
    };
