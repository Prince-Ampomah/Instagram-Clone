import 'dart:async';
import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:instagram_clone/core/widgets/cus_video_player.dart';

import '../../../controller/post_controller/like_controller.dart';
import '../../../model/post_model/post_model.dart';

class PostVideoView extends StatefulWidget {
  const PostVideoView({super.key, this.video, this.postModel});

  final List<dynamic>? video;
  final PostModel? postModel;

  @override
  State<PostVideoView> createState() => _PostVideoViewState();
}

class _PostVideoViewState extends State<PostVideoView>
    with TickerProviderStateMixin {
  late Animation _heartAnimation;
  late AnimationController _heartAnimationController;

  VideoPlayerController? videoPlayerController;

  Timer? timer;

  bool showLikeIcon = false;

  void likeIconVisibiltyTimer() {
    setState(() {
      showLikeIcon = true;
      _heartAnimationController.forward();
    });

    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        showLikeIcon = false;
        _heartAnimationController.stop();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    initAnimationController();
    initVideoPlayerController();
  }

  initVideoPlayerController() async {
    bool isValidURL = Uri.parse(widget.video!.first).isAbsolute;

    if (isValidURL) {
      var file = await DefaultCacheManager().getSingleFile(widget.video!.first);
      videoPlayerController = VideoPlayerController.file(file);
    } else {
      videoPlayerController =
          VideoPlayerController.file(File(widget.video!.first));
    }

    if (!mounted) {
      return;
    }
    videoPlayerController = videoPlayerController!
      ..initialize().then((value) {});
  }

  void initAnimationController() {
    _heartAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
      reverseDuration: const Duration(milliseconds: 400),
    );
    _heartAnimation = Tween(begin: 90.0, end: 100.0).animate(
      CurvedAnimation(
        curve: Curves.elasticOut,
        reverseCurve: Curves.ease,
        parent: _heartAnimationController,
      ),
    );

    _heartAnimationController.addStatusListener(
      (AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _heartAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _heartAnimationController.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    _heartAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          videoPlayerController != null &&
                  videoPlayerController!.value.isPlaying
              ? videoPlayerController!.pause()
              : videoPlayerController!.play();
        });
      },
      onDoubleTap: () async {
        if (widget.postModel!.id != null) {
          await LikeController.instance.likePostOnly(widget.postModel!.id!);
          likeIconVisibiltyTimer();
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            height: size.height * 0.70,
            width: size.width,
            child: CustomOriginalVideoPlayer(
              videoPath: widget.video!.first,
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
            Positioned(
              top: size.height * 0.30,
              width: size.width * 0.40,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      videoPlayerController != null &&
                              videoPlayerController!.value.isPlaying
                          ? videoPlayerController!.pause()
                          : videoPlayerController!.play();
                    });
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (showLikeIcon)
            Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _heartAnimationController,
                builder: (context, child) {
                  return Icon(
                    Icons.favorite,
                    size: _heartAnimation.value,
                    color: Colors.white,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
