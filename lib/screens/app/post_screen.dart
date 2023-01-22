import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/scaffold_snackbar.dart';
import '../../models/private_user/private_post.dart';
import 'package:intl/intl.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, this.navigatorKey, required this.privatePost});
  final navigatorKey;
  final PrivatePost privatePost;

  @override
  State<PostScreen> createState() =>
      _PostScreenState(navigatorKey: navigatorKey, privatePost: privatePost);
}

class _PostScreenState extends State<PostScreen> {
  final navigatorKey;
  final PrivatePost privatePost;
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  int carouselPosition = 0;
  _PostScreenState({required this.navigatorKey, required this.privatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: false,
        title: Text('Gönderi'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostArea(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${NumberFormat("#,##0").format(privatePost.like_count)} beğeni',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => _save(),
                  child: Text('Download'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '${privatePost.caption ?? ""}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _save() async {
    String url = "";
    var media_type = privatePost.media_type;
    if (media_type == 1) {
      url = privatePost.image_url ?? "";
    } else if (media_type == 8) {
      url = privatePost.carousel_media?[carouselPosition].image_url ?? "";
    }
    var response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
      name: privatePost.code,
    );
    ScaffoldSnackbar(context: context, message: "Medya galerinize kaydedildi.");
  }

  Widget _buildPostArea() {
    if (privatePost.media_type == 1) {
      return _buildPicture();
    }
    if (privatePost.media_type == 8) {
      return _buildCarousel();
    }
    return Container();
  }

  Widget _buildCarousel() {
    final pages = privatePost.carousel_media!.map((e) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: CachedImage(
          imageUrl: e.image_url,
          width: MediaQuery.of(context).size.width,
        ),
      );
    }).toList();
    return Column(
      children: [
        SizedBox(
          height: 320,
          child: PageView.builder(
            padEnds: false,
            controller: controller,
            // itemCount: pages.length,
            itemBuilder: (_, index) {
              return pages[index % pages.length];
            },
            onPageChanged: (value) => setState(
              () => carouselPosition = value % pages.length,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmoothPageIndicator(
            controller: controller, // PageController
            count: pages.length,
            effect: WormEffect(
                dotWidth: 10,
                dotHeight: 10,
                activeDotColor: Colors.white), // your preferred effect
            onDotClicked: (index) {},
          ),
        ),
      ],
    );
  }

  Widget _buildPicture() {
    return CachedImage(
      imageUrl: privatePost.image_url,
      width: MediaQuery.of(context).size.width,
      height: 350,
    );
  }
}
