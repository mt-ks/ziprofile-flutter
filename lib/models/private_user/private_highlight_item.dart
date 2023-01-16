import 'package:json_annotation/json_annotation.dart';

part 'private_highlight_item.g.dart';

@JsonSerializable()
class PrivateHighlightItem {
  int? taken_at;
  String? id;
  int? media_type;
  String? image_url;
  String? video_url;

  PrivateHighlightItem(
    this.taken_at,
    this.id,
    this.media_type,
    this.image_url,
    this.video_url,
  );

  factory PrivateHighlightItem.fromJson(Map<String, dynamic> json) =>
      _$PrivateHighlightItemFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateHighlightItemToJson(this);
}
