import 'package:json_annotation/json_annotation.dart';

import 'tray.dart';

part 'reels_tray.g.dart';

@JsonSerializable()
class ReelsTray {
  List<Tray>? tray;
  String? story_ranking_token;
  String? status;

  ReelsTray(
    this.tray,
    this.story_ranking_token,
    this.status,
  );

  factory ReelsTray.fromJson(Map<String, dynamic> json) =>
      _$ReelsTrayFromJson(json);

  Map<String, dynamic> toJson() => _$ReelsTrayToJson(this);
}
