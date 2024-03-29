import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:instagram_clone/controller/reel_controller/reel_controller.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/widgets/cus_list_tile.dart';
import 'package:instagram_clone/core/widgets/cus_primary_button.dart';
import 'package:video_player/video_player.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/cus_appbar.dart';
import '../../core/widgets/cus_video_player.dart';

class AddNewReel extends StatefulWidget {
  const AddNewReel({super.key});

  @override
  State<AddNewReel> createState() => _AddNewReelState();
}

class _AddNewReelState extends State<AddNewReel> {
  @override
  void initState() {
    super.initState();
  }

  VideoPlayerController? videoPlayerController;

  initVideoPlayerController() async {
    bool isValidURL = Uri.parse(ReelController.instance.media.first).isAbsolute;

    if (isValidURL) {
      var file = await DefaultCacheManager()
          .getSingleFile(ReelController.instance.media.first);
      videoPlayerController = VideoPlayerController.file(file);
    } else {
      videoPlayerController =
          VideoPlayerController.file(File(ReelController.instance.media.first));
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
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'New Reel',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                await ReelController.instance.addNewReel();
              },
              icon: const Icon(
                Icons.check,
                color: AppColors.buttonColor,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CustomOriginalVideoPlayer(
                      videoPath: ReelController.instance.media.first,
                      aspectRatio:
                          videoPlayerController?.value.aspectRatio ?? 1,
                      onInitController: (controller) {
                        setState(() {
                          videoPlayerController = controller;
                        });
                      },
                    ),
                  ),
                ),
                10.ph,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: ReelController.captionController,
                    maxLines: 20,
                    minLines: 1,
                    textInputAction: TextInputAction.newline,
                    cursorColor: AppColors.blackColor,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write a caption...',
                    ),
                    onSaved: (value) {
                      ReelController.captionController.text = value!.trim();
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            const Column(
              children: [
                CustomListTile(
                  title: 'Tag people',
                  titleStyle: TextStyle(fontWeight: FontWeight.bold),
                  leading: Icon(Icons.perm_contact_calendar_outlined),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
                CustomListTile(
                  title: 'Add topics',
                  titleStyle: TextStyle(fontWeight: FontWeight.bold),
                  leading: Icon(Icons.tag_outlined),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PrimaryOutlinedButton(
                  onPressed: () {},
                  title: 'Save draft',
                ),
                PrimaryButton(
                  onPressed: () {},
                  title: 'Next',
                  borderRadius: 10,
                  bgColor: AppColors.buttonColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
