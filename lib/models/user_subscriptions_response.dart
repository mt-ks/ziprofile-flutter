import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/user_subscriptions_details.dart';

part 'user_subscriptions_response.g.dart';

@JsonSerializable()
class UserSubscriptionsResponse {
  String status;
  List<UserSubscriptionsDetails> purchases;

  UserSubscriptionsResponse(this.status, this.purchases);

  factory UserSubscriptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserSubscriptionsResponseToJson(this);
}
