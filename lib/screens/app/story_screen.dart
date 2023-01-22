import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:story_view/story_view.dart';
import '../../models/private_user/private_story.dart';
import '../../services/video_download.dart';
import '../../widgets/scaffold_snackbar.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({
    super.key,
    required this.privateStory,
  });
  final List<PrivateStory> privateStory;
  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final storyController = StoryController();
  int storyIndex = 0;
  List<StoryItem> storyItems = [];

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  _downloadStory() async {
    storyController.pause();
    ScaffoldSnackbar(context: context, message: "Hikaye indiriliyor...");
    var currentStory = widget.privateStory[storyIndex];
    if (currentStory.media_type == 1) {
      _downloadMedia(currentStory.image_url!);
    } else {
      _downloadVideo(currentStory.video_url!);
    }
  }

  _downloadMedia(String image_url) async {
    var response = await Dio().get(
      image_url,
      options: Options(responseType: ResponseType.bytes),
    );
    await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
      name: DateTime.now().toString(),
    );
    ScaffoldSnackbar(context: context, message: "Hikaye indirildi!");
    storyController.play();
  }

  _downloadVideo(String video_url) {
    VideoDownload(
      videoUrl: video_url,
      onReceiveProgress: (value) {
        print(value);
      },
      onCompleted: () {
        storyController.play();
        ScaffoldSnackbar(context: context, message: "Hikaye indirildi!");
      },
    ).downloadVideo();
  }

  @override
  Widget build(BuildContext context) {
    for (var storyItem in widget.privateStory) {
      if (storyItem.media_type == 1) {
        storyItems.add(
          StoryItem.pageImage(
            url: storyItem.image_url!,
            controller: storyController,
          ),
        );
      } else {
        print(storyItem.video_url);
        storyItems.add(
          StoryItem.pageVideo(
            storyItem.video_url!,
            controller: storyController,
          ),
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Hikayeler'),
            Spacer(),
            ElevatedButton(
              onPressed: () => _downloadStory(),
              child: Text('Hikayeyi İndir'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[850]),
              ),
            )
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: StoryView(
        onStoryShow: (value) {
          storyIndex = storyItems.indexOf(value);
          print(storyIndex);
        },
        controller: storyController,
        storyItems: storyItems,
      ),
    );
  }
}
