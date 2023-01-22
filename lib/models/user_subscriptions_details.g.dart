// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_subscriptions_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSubscriptionsDetails _$UserSubscriptionsDetailsFromJson(
        Map<String, dynamic> json) =>
    UserSubscriptionsDetails(
      json['app_account_token'] as String,
      json['notification_type'] as String,
      json['subtype'] as String,
      json['transaction_id'] as String,
      json['product_id'] as String,
      json['purchase_date'] as String,
      json['expires_date'] as String,
      json['quantity'] as int,
      json['type'] as String,
      json['in_app_ownership_type'] as String,
      json['auto_renew_status'] as int,
    );

Map<String, dynamic> _$UserSubscriptionsDetailsToJson(
        UserSubscriptionsDetails instance) =>
    <String, dynamic>{
      'app_account_token': instance.app_account_token,
      'notification_type': instance.notification_type,
      'subtype': instance.subtype,
      'transaction_id': instance.transaction_id,
      'product_id': instance.product_id,
      'purchase_date': instance.purchase_date,
      'expires_date': instance.expires_date,
      'quantity': instance.quantity,
      'type': instance.type,
      'in_app_ownership_type': instance.in_app_ownership_type,
      'auto_renew_status': instance.auto_renew_status,
    };
