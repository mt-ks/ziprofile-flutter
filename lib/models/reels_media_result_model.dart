import 'package:json_annotation/json_annotation.dart';
import './reel.dart';

part 'reels_media_result_model.g.dart';

@JsonSerializable()
class ReelsMediaResultModel {
  Map<dynamic, Reel> reels;
  String? status;
  ReelsMediaResultModel(this.reels, this.status);

  factory ReelsMediaResultModel.fromJson(Map<String, dynamic> json) =>
      _$ReelsMediaResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReelsMediaResultModelToJson(this);
}
