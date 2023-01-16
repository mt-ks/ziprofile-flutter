import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class VideoDownload {
  final String videoUrl;
  ValueChanged<int> onReceiveProgress;
  Function onCompleted;
  VideoDownload(
      {required this.videoUrl,
      required this.onReceiveProgress,
      required this.onCompleted});

  Future<void> downloadVideo() async {
    final appDocDirectory = await getAppDocDirectory();

    final finalVideoPath = join(
      appDocDirectory.path,
      'Video-${DateTime.now().millisecondsSinceEpoch}.mp4',
    );

    final dio = Dio();

    await dio.download(
      videoUrl,
      finalVideoPath,
      onReceiveProgress: (actualBytes, totalBytes) {
        final percentage = actualBytes / totalBytes * 100;
        onReceiveProgress(percentage.toInt());
      },
    );

    await saveDownloadedVideoToGallery(videoPath: finalVideoPath);
    await removeDownloadedVideo(videoPath: finalVideoPath);
    onCompleted();
  }

  Future<Directory> getAppDocDirectory() async {
    if (Platform.isIOS) {
      return getApplicationDocumentsDirectory();
    }

    return (await getExternalStorageDirectory())!;
  }

  Future<void> saveDownloadedVideoToGallery({required String videoPath}) async {
    await ImageGallerySaver.saveFile(videoPath);
  }

  Future<void> removeDownloadedVideo({required String videoPath}) async {
    try {
      Directory(videoPath).deleteSync(recursive: true);
    } catch (error) {
      debugPrint('$error');
    }
  }
}
