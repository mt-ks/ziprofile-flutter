// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_subscriptions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSubscriptionsResponse _$UserSubscriptionsResponseFromJson(
        Map<String, dynamic> json) =>
    UserSubscriptionsResponse(
      json['status'] as String,
      (json['purchases'] as List<dynamic>)
          .map((e) =>
              UserSubscriptionsDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserSubscriptionsResponseToJson(
        UserSubscriptionsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'purchases': instance.purchases,
    };
