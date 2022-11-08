import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/reels_item.dart';
import 'package:ziprofile/models/user.dart';

part 'reel.g.dart';

@JsonSerializable()
class Reel {
  dynamic id;
  User user;
  List<ReelsItem> items;

  Reel(this.id, this.user, this.items);

  factory Reel.fromJson(Map<String, dynamic> json) => _$ReelFromJson(json);

  Map<String, dynamic> toJson() => _$ReelToJson(this);
}
