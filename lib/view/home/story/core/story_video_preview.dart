import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

import '../../../../controller/story_controller/story_controller.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../core/widgets/cus_video_player.dart';

class StoryVideoPreview extends StatefulWidget {
  const StoryVideoPreview({
    super.key,
    required this.videoPath,
  });

  final String videoPath;

  @override
  State<StoryVideoPreview> createState() => _StoryVideoPreviewState();
}

class _StoryVideoPreviewState extends State<StoryVideoPreview> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    initVideoPlayerController();
  }

  initVideoPlayerController() async {
    bool isValidURL = Uri.parse(widget.videoPath).isAbsolute;

    if (isValidURL) {
      var file = await DefaultCacheManager().getSingleFile(widget.videoPath);
      videoPlayerController = VideoPlayerController.file(file);
    } else {
      videoPlayerController =
          VideoPlayerController.file(File(widget.videoPath));
    }

    if (!mounted) {
      return;
    }
    videoPlayerController = videoPlayerController!
      ..initialize().then(
        (value) => setState(() {
          // videoPlayerController!.play();
        }),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (videoPlayerController != null &&
                        !videoPlayerController!.value.isPlaying) {
                      videoPlayerController!.play();
                    } else {
                      videoPlayerController!.pause();
                    }
                  });
                },
                child: Stack(
                  children: [
                    CustomOriginalVideoPlayer(
                      videoPath: widget.videoPath,
                      aspectRatio:
                          videoPlayerController?.value.aspectRatio ?? 1,
                      onInitController: (controller) {
                        setState(() {
                          videoPlayerController = controller;
                        });
                      },
                    ),
                    if (videoPlayerController != null &&
                        !videoPlayerController!.value.isPlaying)
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            10.ph,
            GestureDetector(
              onTap: () {
                StoryController.instance.addNewStory(Const.videoStoryType);
                popUntil(context, 2);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 13,
                ),
                margin: const EdgeInsets.fromLTRB(5, 3, 20, 25),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
