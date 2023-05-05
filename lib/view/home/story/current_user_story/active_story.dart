import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/view/home/story/story_highlight.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/cus_cached_image.dart';
import '../../../../core/widgets/cus_circular_image.dart';
import '../../../../model/story_model/story_model.dart';

class ActiveCurrentStory extends StatelessWidget {
  const ActiveCurrentStory({
    super.key,
    required this.storyModel,
  });

  final StoryModel storyModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            sendToPage(
              context,
              StoryHighlightView(
                storyModel: storyModel,
                isCurrentUserStory: true,
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFBA3535),
                    width: 2.00,
                  ),
                ),
                child: Container(
                  height: 75,
                  width: 75,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.00,
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: AppColors.storyBorderColors,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: storyModel.userProfileImage != null
                        ? CustomCachedImage(
                            imageUrl: storyModel.userProfileImage!,
                            fit: BoxFit.cover,
                          )
                        : const CircularImageContainer(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Text(
            'Your story',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
