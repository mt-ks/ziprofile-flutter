import 'package:json_annotation/json_annotation.dart';

part 'private_carousel.g.dart';

@JsonSerializable()
class PrivateCarousel {
  int? media_type;
  String? image_url;
  String? video_url;
  String? carousel_parent_id;

  PrivateCarousel(
    this.media_type,
    this.image_url,
    this.video_url,
    this.carousel_parent_id,
  );

  factory PrivateCarousel.fromJson(Map<String, dynamic> json) =>
      _$PrivateCarouselFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateCarouselToJson(this);
}
