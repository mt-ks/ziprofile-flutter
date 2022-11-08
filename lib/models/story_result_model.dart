import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/reel.dart';

part 'story_result_model.g.dart';

@JsonSerializable()
class StoryResultModel {
  Reel? reel;
  String? status;

  StoryResultModel(this.reel);

  factory StoryResultModel.fromJson(Map<String, dynamic> json) =>
      _$StoryResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryResultModelToJson(this);
}
