import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage(
      {super.key, required this.imageUrl, this.width = 50, this.height = 50});

  final String? imageUrl;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      width: width,
      height: height,
      imageUrl: imageUrl ?? "...",
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        color: Colors.white,
      ),
    );
  }
}
