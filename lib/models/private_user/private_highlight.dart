import 'package:json_annotation/json_annotation.dart';
import './private_highlight_item.dart';

part 'private_highlight.g.dart';

@JsonSerializable()
class PrivateHighlight {
  dynamic id;
  String? title;
  dynamic created_at;
  int? media_count;
  String? cover_media;
  List<PrivateHighlightItem>? items;

  PrivateHighlight(
    this.id,
    this.title,
    this.created_at,
    this.media_count,
    this.cover_media,
    this.items,
  );

  factory PrivateHighlight.fromJson(Map<String, dynamic> json) =>
      _$PrivateHighlightFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateHighlightToJson(this);
}
