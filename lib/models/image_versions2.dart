import 'package:json_annotation/json_annotation.dart';
import './candidates.dart';

part 'image_versions2.g.dart';

@JsonSerializable()
class ImageVersions2 {
  List<Candidates>? candidates;

  ImageVersions2(this.candidates);

  factory ImageVersions2.fromJson(Map<String, dynamic> json) =>
      _$ImageVersions2FromJson(json);

  Map<String, dynamic> toJson() => _$ImageVersions2ToJson(this);
}
