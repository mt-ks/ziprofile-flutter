// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_following.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFollowing _$UserFollowingFromJson(Map<String, dynamic> json) =>
    UserFollowing(
      (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserFollowingToJson(UserFollowing instance) =>
    <String, dynamic>{
      'users': instance.users,
    };
