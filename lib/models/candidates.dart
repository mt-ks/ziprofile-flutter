import 'package:json_annotation/json_annotation.dart';

part 'candidates.g.dart';

@JsonSerializable()
class Candidates {
  int? width;
  int? height;
  String? url;

  Candidates(this.width, this.height, this.url);

  factory Candidates.fromJson(Map<String, dynamic> json) =>
      _$CandidatesFromJson(json);

  Map<String, dynamic> toJson() => _$CandidatesToJson(this);
}
