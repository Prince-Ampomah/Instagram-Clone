import 'package:flutter/material.dart';

import '../../../../controller/story_controller/story_controller.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../core/widgets/cus_video_player.dart';

class StoryVideoPreview extends StatelessWidget {
  const StoryVideoPreview({
    super.key,
    required this.videoPath,
  });

  final String videoPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: CusVideoPlayer(videoPath: videoPath)),
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
