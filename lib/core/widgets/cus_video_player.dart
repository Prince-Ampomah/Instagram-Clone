import 'dart:io';

import 'package:flutter/material.dart';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../constants/constants.dart';
import '../theme/app_colors.dart';

class CusVideoPlayer extends StatefulWidget {
  const CusVideoPlayer({
    super.key,
    required this.videoPath,
    this.aspecRatio = 0.6,
    this.showControllBar = true,
    this.showSettingsButton = true,
    this.playOnlyOnce = true,
    this.showProgressBar = true,
    this.showDurationPlayed = true,
    this.onInitController,
    this.controlBarDecoration = const BoxDecoration(
      borderRadius: BorderRadius.zero,
    ),
  });

  final String videoPath;
  final double? aspecRatio;
  final bool? showControllBar,
      showSettingsButton,
      playOnlyOnce,
      showProgressBar,
      showDurationPlayed;
  final BoxDecoration controlBarDecoration;

  final Function(VideoPlayerController controller)? onInitController;

  @override
  State<CusVideoPlayer> createState() => _CusVideoPlayerState();
}

class _CusVideoPlayerState extends State<CusVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  CustomVideoPlayerController? _customVideoPlayerController;

  DefaultCacheManager defaultCacheManager = DefaultCacheManager();

  @override
  void initState() {
    super.initState();
    initControllers();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.blackColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
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

    if (!mounted) return;

    videoPlayerController = videoPlayerController
      ..initialize().then((value) => setState(() {
            widget.onInitController?.call(videoPlayerController);
          }));

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
      customVideoPlayerSettings: CustomVideoPlayerSettings(
        controlBarDecoration: widget.controlBarDecoration,
        controlBarAvailable: widget.showControllBar!,
        settingsButtonAvailable: widget.showSettingsButton!,
        playOnlyOnce: widget.playOnlyOnce!,
        showDurationPlayed: widget.showDurationPlayed!,
        customVideoPlayerProgressBarSettings:
            CustomVideoPlayerProgressBarSettings(
          showProgressBar: widget.showProgressBar!,
        ),
        placeholderWidget: const Center(child: CustomCircularProgressBar()),
      ),
    );
  }

  @override
  void dispose() {
    if (_customVideoPlayerController != null) {
      _customVideoPlayerController!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_customVideoPlayerController != null) {
      return CustomVideoPlayer(
        customVideoPlayerController: _customVideoPlayerController!,
      );
    } else {
      return const Center(child: CustomCircularProgressBar());
    }
  }
}

class CustomOriginalVideoPlayer extends StatefulWidget {
  const CustomOriginalVideoPlayer({
    // required this.controller,
    required this.videoPath,
    // this.width,
    // this.height,
    this.aspectRatio = 1,
    this.onInitController,
    // this.rawPlayer = true,
    super.key,
  });

  /// Invoked when the `VideoPlayerController` is initiated
  /// You can use this method to get the controller
  final Function(VideoPlayerController controller)? onInitController;

  /// The aspect ratio of the video
  final double aspectRatio;

  /// Path to the video file
  /// Can be a Valid `URI` or a `Directory`
  final String videoPath;

  @override
  State<CustomOriginalVideoPlayer> createState() =>
      _CustomOriginalVideoPlayerState();
}

class _CustomOriginalVideoPlayerState extends State<CustomOriginalVideoPlayer>
    with WidgetsBindingObserver {
  VideoPlayerController? controller;
  // Future<void>? _initializeVideoPlayerFuture;
  bool isLoaded = false;

  @override
  void initState() {
    _initController(widget.videoPath).then((_) {
      controller?.initialize().then((value) {
        setState(() {
          isLoaded = true;
          widget.onInitController?.call(controller!);
        });
      });
    });
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> _initController(String videoPath) async {
    /// Initialize the [isValid] if the [videoFilePath] provided in a valid URL
    bool isValidURL = Uri.parse(videoPath).isAbsolute;

    if (isValidURL) {
      var file = await DefaultCacheManager().getSingleFile(videoPath);
      controller = VideoPlayerController.file(file);
    } else {
      controller = VideoPlayerController.file(File(videoPath));
    }
  }

  @override
  void dispose() {
    // dispose off the video player controller when not in use

    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        controller?.dispose();
        logger.i('Inactive');
        break;

      case AppLifecycleState.resumed:
        controller?.initialize();
        logger.i('Resumed');
        break;

      case AppLifecycleState.paused:
        controller?.pause();
        logger.i('Paused');
        break;

      case AppLifecycleState.detached:
        controller?.dispose();
        logger.i('detached');
        break;

      default:
        controller?.dispose();
        logger.i('default');
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded && controller != null) {
      return AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: VideoPlayer(controller!),
      );
    } else {
      return const Center(child: CustomCircularProgressBar());

      // return AspectRatio(
      //   aspectRatio: widget.aspectRatio,
      //   child: Container(
      //     height: 200,
      //     decoration: const BoxDecoration(
      //       color: Colors.transparent,
      //     ),
      //     child: const ShimmerEffect.rectangular(height: 200),
      //     // child: Shimmer.fromColors(
      //     //   baseColor: Colors.grey,
      //     //   highlightColor: Colors.grey[600]!,
      //     //   period: const Duration(seconds: 2),
      //     //   child: const Icon(
      //     //     Icons.videocam_outlined,
      //     //     size: 70,
      //     //   ),
      //     // ),
      //   ),
      // );
    }
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
