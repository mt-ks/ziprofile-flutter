import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/private_user/private_user.dart';

part 'search_users_response.g.dart';

@JsonSerializable()
class SearchUsersResponse {
  String status;
  List<PrivateUser> users;
  String? access_token;

  SearchUsersResponse(this.status, this.users, this.access_token);

  factory SearchUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUsersResponseToJson(this);
}
