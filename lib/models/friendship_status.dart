import 'package:json_annotation/json_annotation.dart';

part 'friendship_status.g.dart';

@JsonSerializable()
class FriendsipStatus {
  bool following;
  bool is_private;
  bool incoming_request;
  bool outgoing_request;
  bool is_bestie;
  bool is_restricted;
  bool is_feed_favorite;

  FriendsipStatus(
    this.following,
    this.is_private,
    this.incoming_request,
    this.outgoing_request,
    this.is_bestie,
    this.is_feed_favorite,
    this.is_restricted,
  );

  factory FriendsipStatus.fromJson(Map<String, dynamic> json) =>
      _$FriendsipStatusFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsipStatusToJson(this);
}
