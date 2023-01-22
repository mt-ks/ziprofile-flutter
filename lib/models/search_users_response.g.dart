// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_users_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUsersResponse _$SearchUsersResponseFromJson(Map<String, dynamic> json) =>
    SearchUsersResponse(
      json['status'] as String,
      (json['users'] as List<dynamic>)
          .map((e) => PrivateUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['access_token'] as String?,
    );

Map<String, dynamic> _$SearchUsersResponseToJson(
        SearchUsersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'users': instance.users,
      'access_token': instance.access_token,
    };
