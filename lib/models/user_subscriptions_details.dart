import 'package:json_annotation/json_annotation.dart';

part 'user_subscriptions_details.g.dart';

@JsonSerializable()
class UserSubscriptionsDetails {
  String app_account_token;
  String notification_type;
  String subtype;
  String transaction_id;
  String product_id;
  String purchase_date;
  String expires_date;
  int quantity;
  String type;
  String in_app_ownership_type;
  int auto_renew_status;

  UserSubscriptionsDetails(
    this.app_account_token,
    this.notification_type,
    this.subtype,
    this.transaction_id,
    this.product_id,
    this.purchase_date,
    this.expires_date,
    this.quantity,
    this.type,
    this.in_app_ownership_type,
    this.auto_renew_status,
  );

  factory UserSubscriptionsDetails.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionsDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserSubscriptionsDetailsToJson(this);
}
