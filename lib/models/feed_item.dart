import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/carousel_media.dart';
import './image_versions2.dart';
import './user.dart';
import './video_versions.dart';

import 'caption.dart';

part 'feed_item.g.dart';

@JsonSerializable()
class FeedItem {
  dynamic taken_at;
  dynamic pk;
  String? id;
  int? media_type;
  String? code;
  bool? like_and_view_counts_disabled;
  User? user;
  int? like_count;
  bool? has_liked;
  ImageVersions2? image_versions2;
  Caption? caption;
  List<VideoVersions>? video_versions;
  List<CarouselMedia>? carousel_media;
  int? view_count;
  int? play_count;

  FeedItem(
    this.taken_at,
    this.pk,
    this.id,
    this.media_type,
    this.code,
    this.like_and_view_counts_disabled,
    this.user,
    this.like_count,
    this.has_liked,
    this.image_versions2,
    this.video_versions,
    this.view_count,
    this.play_count,
    this.caption,
    this.carousel_media,
  );

  factory FeedItem.fromJson(Map<String, dynamic> json) =>
      _$FeedItemFromJson(json);

  Map<String, dynamic> toJson() => _$FeedItemToJson(this);
}
