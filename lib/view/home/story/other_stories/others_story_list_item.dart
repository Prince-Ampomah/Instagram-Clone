import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../core/widgets/cus_cached_image.dart';
import '../../../../model/story_model/story_model.dart';
import '../story_highlight.dart';

class UsersStory extends StatelessWidget {
  const UsersStory({
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
              StoryHighlightView(storyModel: storyModel),
            );
          },
          child: Container(
            height: 75,
            width: 75,
            padding: const EdgeInsets.all(2.0),
            margin: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.transparent,
                width: 0.00,
              ),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColors.storyBorderColors,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: CustomCachedImage(
                imageUrl: storyModel.userProfileImage!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Text(
            storyModel.userHandle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
