import 'package:json_annotation/json_annotation.dart';

part 'private_story.g.dart';

@JsonSerializable()
class PrivateStory {
  int? taken_at;
  String? id;
  int? media_type;
  String? image_url;
  String? video_url;

  PrivateStory(
    this.taken_at,
    this.id,
    this.media_type,
    this.image_url,
    this.video_url,
  );

  factory PrivateStory.fromJson(Map<String, dynamic> json) =>
      _$PrivateStoryFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateStoryToJson(this);
}
