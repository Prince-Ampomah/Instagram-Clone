import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:instagram_clone/model/reel_model/reel_model.dart';
import 'package:instagram_clone/view/reel/reel_reaction.dart';
import 'package:instagram_clone/view/reel/reel_user_profile.dart';
import 'package:video_player/video_player.dart';

import '../../controller/reel_controller/reel_like_controller.dart';
import '../../core/widgets/cus_video_player.dart';

String vd =
    'https://firebasestorage.googleapis.com/v0/b/instagram-clone-b31aa.appspot.com/o/reels%2FurraCrHDeY0V4D0gcnF7%2FREC1820518638010963750.mp4?alt=media&token=00bbaa2f-46fa-4f76-a233-a4c1fd3096bd';

class ReelListItem extends StatelessWidget {
  const ReelListItem({super.key, required this.snapshot});

  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        ReelModel reelModel =
            ReelModel.fromJson(snapshot.data!.docs[index].data());
        return ReelVideo(reelModel: reelModel);
      },
    );
  }
}

class ReelVideo extends StatefulWidget {
  const ReelVideo({super.key, required this.reelModel});

  final ReelModel reelModel;

  @override
  State<ReelVideo> createState() => _ReelVideoState();
}

class _ReelVideoState extends State<ReelVideo>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  VideoPlayerController? videoPlayerController;

  bool showVolumeIcon = false;
  bool showLikeIcon = false;

  Timer? timer;

  late Animation _heartAnimation;
  late AnimationController _heartAnimationController;

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

  initVideoPlayerController() async {
    bool isValidURL = Uri.parse(widget.reelModel.media).isAbsolute;

    if (isValidURL) {
      File file =
          await DefaultCacheManager().getSingleFile(widget.reelModel.media);
      videoPlayerController = VideoPlayerController.file(file);
    } else {
      videoPlayerController =
          VideoPlayerController.file(File(widget.reelModel.media));
    }

    if (!mounted) return;

    videoPlayerController = videoPlayerController!
      ..initialize().then(
        (value) {},
      );
  }

  void muteAndUnmuteSound() {
    setState(() {
      showVolumeIcon = true;
    });

    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        showVolumeIcon = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // muteAndUnmuteSound();
    initVideoPlayerController();
    initAnimationController();
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
          if (videoPlayerController != null &&
              videoPlayerController!.value.volume == 1.0) {
            videoPlayerController!.setVolume(0.0);
          } else {
            videoPlayerController!.setVolume(1.0);
          }

          showVolumeIcon = !showVolumeIcon;
        });
      },
      onDoubleTap: () async {
        if (widget.reelModel.id != null) {
          await ReelLikeController.instance.likePostOnly(widget.reelModel.id!);
          likeIconVisibiltyTimer();
        }
      },
      child: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: CustomOriginalVideoPlayer(
              videoPath: widget.reelModel.media,
              aspectRatio: videoPlayerController?.value.aspectRatio ?? 1,
              onInitController: (controller) {
                // play playing automatically and repeat
                controller.play();
                controller.setLooping(true);

                setState(() {
                  videoPlayerController = controller;
                });
              },
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
                    color: Colors.red,
                  ),
                );
              },
            ),

          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     padding: const EdgeInsets.all(8),
          //     margin: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          //     decoration: BoxDecoration(
          //       color: Colors.black.withOpacity(0.4),
          //       shape: BoxShape.circle,
          //     ),
          //     child: Icon(
          //       showVolumeIcon
          //           ? Icons.volume_up_outlined
          //           : Icons.volume_off_outlined,
          //       color: Colors.white,
          //       size: 50,
          //     ),
          //   ),
          // ),
          // const Align(
          //   alignment: Alignment.center,
          //   child: Icon(
          //     Icons.favorite,
          //     color: Colors.red,
          //     size: 100,
          //   ),
          // ),

          ReelReactionButtons(
            reelModel: widget.reelModel,
          ),
          ReelUserProfile(
            userId: widget.reelModel.userId!,
            reelCaption: widget.reelModel.caption,
          ),
        ],
      ),
    );
  }
}
