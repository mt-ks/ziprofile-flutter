// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloudConfig _$CloudConfigFromJson(Map<String, dynamic> json) => CloudConfig(
      json['auth_factory'] as int,
      json['service_address'] as String,
      json['service_provider'] as String,
    );

Map<String, dynamic> _$CloudConfigToJson(CloudConfig instance) =>
    <String, dynamic>{
      'auth_factory': instance.auth_factory,
      'service_address': instance.service_address,
      'service_provider': instance.service_provider,
    };
