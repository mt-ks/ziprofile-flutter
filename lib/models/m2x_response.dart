import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/private_user/private_user_info_response.dart';

part 'm2x_response.g.dart';

@JsonSerializable()
class M2XResponse {
  List<PrivateUserInfoResponse> userResponses;

  M2XResponse(this.userResponses);

  factory M2XResponse.fromJson(Map<String, dynamic> json) =>
      _$M2XResponseFromJson(json);

  Map<String, dynamic> toJson() => _$M2XResponseToJson(this);
}
