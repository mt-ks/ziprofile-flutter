import 'package:json_annotation/json_annotation.dart';
import './feed_item.dart';
import './user.dart';

part 'feeds.g.dart';

@JsonSerializable()
class Feeds {
  List<FeedItem>? items;
  String? status;
  User? user;

  Feeds(this.items, this.status, this.user);

  factory Feeds.fromJson(Map<String, dynamic> json) => _$FeedsFromJson(json);

  Map<String, dynamic> toJson() => _$FeedsToJson(this);
}
