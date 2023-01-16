import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/user.dart';

part 'tray.g.dart';

@JsonSerializable()
class Tray {
  dynamic id;
  dynamic latest_reel_media;
  int? seen;
  bool? can_reply;
  String? reel_type;
  User? user;
  int? story_duration_secs;
  int? media_count;
  List<dynamic>? media_ids;

  Tray(
    this.id,
    this.latest_reel_media,
    this.seen,
    this.can_reply,
    this.reel_type,
    this.user,
    this.story_duration_secs,
    this.media_count,
    this.media_ids,
  );

  factory Tray.fromJson(Map<String, dynamic> json) => _$TrayFromJson(json);

  Map<String, dynamic> toJson() => _$TrayToJson(this);
}
