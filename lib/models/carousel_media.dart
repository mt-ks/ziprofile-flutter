import 'package:json_annotation/json_annotation.dart';
import 'package:ziprofile/models/image_versions2.dart';

part 'carousel_media.g.dart';

@JsonSerializable()
class CarouselMedia {
  dynamic id;
  int? media_type;
  ImageVersions2? image_versions2;
  dynamic carousel_parent_id;
  CarouselMedia(
    this.id,
    this.media_type,
    this.image_versions2,
    this.carousel_parent_id,
  );

  factory CarouselMedia.fromJson(Map<String, dynamic> json) =>
      _$CarouselMediaFromJson(json);

  Map<String, dynamic> toJson() => _$CarouselMediaToJson(this);
}
