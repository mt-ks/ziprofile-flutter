import 'package:json_annotation/json_annotation.dart';

part 'caption.g.dart';

@JsonSerializable()
class Caption {
  String? text;
  dynamic pk;
  int? type;

  Caption(this.pk, this.text, this.type);

  factory Caption.fromJson(Map<String, dynamic> json) =>
      _$CaptionFromJson(json);

  Map<String, dynamic> toJson() => _$CaptionToJson(this);
}
