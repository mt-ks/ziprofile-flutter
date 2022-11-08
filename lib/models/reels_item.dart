import 'package:json_annotation/json_annotation.dart';
import './image_versions2.dart';
import './video_versions.dart';
import './user.dart';

part 'reels_item.g.dart';

@JsonSerializable()
class ReelsItem {
  int? taken_at;
  dynamic pk;
  String? id;
  int? media_type;
  String? code;
  User? user;
  ImageVersions2? image_versions2;
  List<VideoVersions>? video_versions;
  bool? has_audio;
  double? video_duration;

  ReelsItem(
    this.taken_at,
    this.pk,
    this.id,
    this.media_type,
    this.code,
    this.user,
    this.image_versions2,
    this.video_versions,
    this.has_audio,
    this.video_duration,
  );

  factory ReelsItem.fromJson(Map<String, dynamic> json) =>
      _$ReelsItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReelsItemToJson(this);
}
