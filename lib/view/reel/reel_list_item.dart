import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:instagram_clone/core/widgets/cus_video_player.dart';
import 'package:instagram_clone/model/reel_model/reel_model.dart';
import 'package:video_player/video_player.dart';

import '../../core/constants/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/cus_circular_image.dart';

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

class _ReelVideoState extends State<ReelVideo> with WidgetsBindingObserver {
  VideoPlayerController? videoPlayerController;

  bool showVolumeIcon = false;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    muteAndUnmuteSound();
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
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return SizedBox(
      height: size.height,
      width: size.width,
      child: GestureDetector(
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
        child: Stack(
          children: [
            CustomOriginalVideoPlayer(
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
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  showVolumeIcon
                      ? Icons.volume_up_outlined
                      : Icons.volume_off_outlined,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            // const Align(
            //   alignment: Alignment.center,
            //   child: Icon(
            //     Icons.favorite,
            //     color: Colors.red,
            //     size: 100,
            //   ),
            // ),
            const ReelReactionButtons(),
            const ReelUserProfile(),
          ],
        ),
      ),
    );
  }
}

class ReelReactionButtons extends StatelessWidget {
  const ReelReactionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                  child: Image.asset(
                    Const.instragramfavoriteIcon,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '20k',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.whiteColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                SizedBox(
                  height: 25,
                  child: Image.asset(
                    Const.instragramCommentIcon,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '320',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.whiteColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 25,
              child: Image.asset(
                Const.instragramSendIcon,
                color: Colors.white,
              ),
            ),
            // const Icon(
            //   Icons.near_me_outlined,
            //   size: 35,
            //   color: Colors.white,
            // ),
            const SizedBox(height: 20),
            const Icon(
              Icons.more_vert_outlined,
              size: 35,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.music_note_outlined,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class ReelUserProfile extends StatelessWidget {
  const ReelUserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularImageContainer(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'User Data',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.whiteColor),
                ),
                const SizedBox(width: 4),
                Text(
                  '4w',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.greyColor),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: AppColors.whiteColor),
                    ),
                  ),
                  child: Text(
                    'Follow',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.whiteColor),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remote Jobs - requires no talking',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.whiteColor),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.sort_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'sarkcess music prod...',
                        style:
                            AppTheme.textStyle(context).labelMedium!.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
