import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/view/reel/add_new_reel.dart';
import 'package:video_player/video_player.dart';

import '../../core/widgets/cus_primary_button.dart';
import '../../core/widgets/cus_video_player.dart';

class PreviewVideo extends StatefulWidget {
  const PreviewVideo({super.key, required this.videoPath});

  final String videoPath;

  @override
  State<PreviewVideo> createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PreviewVideo> {
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
        child: Stack(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CustomOriginalVideoPlayer(
                    videoPath: widget.videoPath,
                    aspectRatio: videoPlayerController?.value.aspectRatio ?? 1,
                    onInitController: (controller) {
                      setState(() {
                        videoPlayerController = controller;
                      });
                    },
                  ),
                ),
                if (videoPlayerController != null &&
                    !videoPlayerController!.value.isPlaying)
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          videoPlayerController != null &&
                                  videoPlayerController!.value.isPlaying
                              ? videoPlayerController!.pause()
                              : videoPlayerController!.play();
                        });
                      },
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
                  ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.white,
                        ),
                      ),
                      8.pw,
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 5),
                child: PrimaryButton(
                  onPressed: () {
                    sendToPage(
                      context,
                      const AddNewReel(),
                    );
                  },
                  title: 'Next',
                  iconData: const Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  borderRadius: 50,
                  bgColor: AppColors.buttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
