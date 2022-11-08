// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultModel _$SearchResultModelFromJson(Map<String, dynamic> json) =>
    SearchResultModel(
      json['num_results'] as int,
      (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['page_token'] as String,
      json['rank_token'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$SearchResultModelToJson(SearchResultModel instance) =>
    <String, dynamic>{
      'num_results': instance.num_results,
      'users': instance.users,
      'page_token': instance.page_token,
      'rank_token': instance.rank_token,
      'status': instance.status,
    };
