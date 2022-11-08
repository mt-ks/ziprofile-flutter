import 'package:json_annotation/json_annotation.dart';

part 'video_versions.g.dart';

@JsonSerializable()
class VideoVersions {
  int? type;
  int? width;
  int? height;
  String? url;
  String? id;

  VideoVersions(this.type, this.height, this.id, this.url, this.width);

  factory VideoVersions.fromJson(Map<String, dynamic> json) =>
      _$VideoVersionsFromJson(json);

  Map<String, dynamic> toJson() => _$VideoVersionsToJson(this);
}
