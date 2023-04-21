import 'dart:io';

import 'package:flutter/material.dart';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CusVideoPlayer extends StatefulWidget {
  const CusVideoPlayer({super.key, required this.videoPath});

  final String videoPath;

  @override
  State<CusVideoPlayer> createState() => _CusVideoPlayerState();
}

class _CusVideoPlayerState extends State<CusVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  CustomVideoPlayerController? _customVideoPlayerController;

  DefaultCacheManager defaultCacheManager = DefaultCacheManager();

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings(
    placeholderWidget: Center(child: CustomCircularProgressBar()),

    // customAspectRatio: 0.6,
  );

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  void initControllers() async {
    bool isValidURL = Uri.parse(widget.videoPath).isAbsolute;
    if (isValidURL) {
      var file = await defaultCacheManager.getSingleFile(widget.videoPath);
      videoPlayerController = VideoPlayerController.file(file);
    } else {
      videoPlayerController =
          VideoPlayerController.file(File(widget.videoPath));
    }

    if (!mounted) {
      return;
    }
    videoPlayerController = videoPlayerController
      ..initialize().then((value) => setState(() {}));

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: _customVideoPlayerController != null
              ? CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController!,
                )
              : const CustomCircularProgressBar(),
        ),
      ),
    );
  }
}

String videoUrlLandscape =
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
String videoUrlPortrait =
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
String longVideo =
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

String video720 =
    "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4";

String video480 =
    "https://www.sample-videos.com/video123/mp4/480/big_buck_bunny_480p_10mb.mp4";

String video240 =
    "https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_10mb.mp4";
