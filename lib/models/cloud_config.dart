import 'package:json_annotation/json_annotation.dart';

part 'cloud_config.g.dart';

@JsonSerializable()
class CloudConfig {
  int auth_factory;
  String service_address;
  String service_provider;

  CloudConfig(this.auth_factory, this.service_address, this.service_provider);

  factory CloudConfig.fromJson(Map<String, dynamic> json) =>
      _$CloudConfigFromJson(json);

  Map<String, dynamic> toJson() => _$CloudConfigToJson(this);
}
