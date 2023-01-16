import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/private_user/private_carousel.dart';

part 'private_post.g.dart';

@JsonSerializable()
class PrivatePost {
  int? taken_at;
  dynamic pk;
  String? id;
  int? media_type;
  String? code;
  bool? like_and_view_counts_disabled;
  String? caption;
  int? like_count;
  List<PrivateCarousel>? carousel_media;
  String? image_url;
  String? video_url;
  PrivatePost(
    this.taken_at,
    this.pk,
    this.id,
    this.media_type,
    this.code,
    this.like_and_view_counts_disabled,
    this.caption,
    this.like_count,
    this.carousel_media,
    this.image_url,
    this.video_url,
  );

  factory PrivatePost.fromJson(Map<String, dynamic> json) =>
      _$PrivatePostFromJson(json);

  Map<String, dynamic> toJson() => _$PrivatePostToJson(this);
}
