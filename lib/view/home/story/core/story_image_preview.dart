import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../controller/story_controller/story_controller.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../core/widgets/cus_cached_image.dart';
import '../../../messages/core/chat_media_preview_back_button.dart';

class StoryImagePreview extends StatelessWidget {
  const StoryImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.blackColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: StoryController.instance.media.length,
                    onPageChanged: StoryController.instance.onPageChanged,
                    itemBuilder: (context, index) {
                      return CustomCachedImage(
                        imageUrl: StoryController.instance.media[index]!,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  const MediaPreviewBackButton(),
                ],
              ),
            ),
            10.ph,
            GestureDetector(
              onTap: () {
                StoryController.instance.addNewStory(Const.imageStoryType);
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
