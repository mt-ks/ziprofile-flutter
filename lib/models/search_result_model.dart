import 'package:json_annotation/json_annotation.dart';
import './user.dart';

part 'search_result_model.g.dart';

@JsonSerializable()
class SearchResultModel {
  int num_results;
  List<User> users;
  String page_token;
  String rank_token;
  String status;

  SearchResultModel(
    this.num_results,
    this.users,
    this.page_token,
    this.rank_token,
    this.status,
  );

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultModelToJson(this);
}
