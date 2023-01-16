// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm2x_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

M2XResponse _$M2XResponseFromJson(Map<String, dynamic> json) => M2XResponse(
      (json['userResponses'] as List<dynamic>)
          .map((e) =>
              PrivateUserInfoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$M2XResponseToJson(M2XResponse instance) =>
    <String, dynamic>{
      'userResponses': instance.userResponses,
    };
