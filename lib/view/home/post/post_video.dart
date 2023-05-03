import 'dart:async';
import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../controller/post_controller/like_controller.dart';
import '../../../core/widgets/cus_video_player.dart';
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

  late VideoPlayerController videoPlayerController;

  DefaultCacheManager defaultCacheManager = DefaultCacheManager();

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
  }

  initVideoPlayer() async {
    bool isValidURL = Uri.parse(widget.video!.first).isAbsolute;

    if (isValidURL) {
      var file = await defaultCacheManager.getSingleFile(widget.video!.first);
      videoPlayerController = VideoPlayerController.file(file);
    } else {
      videoPlayerController =
          VideoPlayerController.file(File(widget.video!.first));
    }

    if (!mounted) return;

    videoPlayerController = videoPlayerController
      ..initialize().then((value) => setState(() {}));
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
    // videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {},
      onDoubleTap: () async {
        if (widget.postModel!.id != null) {
          await LikeController.instance.likePostOnly(widget.postModel!.id!);
          likeIconVisibiltyTimer();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: size.height * 0.50,
            width: size.width,
            child: CusVideoPlayer(
              videoPath: widget.video!.first,
              showControllBar: true,
              showSettingsButton: false,
            ),
          ),
          if (showLikeIcon)
            AnimatedBuilder(
              animation: _heartAnimationController,
              builder: (context, child) {
                return Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.favorite,
                    size: _heartAnimation.value,
                    color: Colors.white,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}