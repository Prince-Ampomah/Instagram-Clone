import 'package:flutter/material.dart';

import '../../../model/story_model/story_model.dart';
import 'current_user_story.dart';
import 'users_story.dart';

class Story extends StatelessWidget {
  const Story({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const CurrentUserStory(),
          ...List.generate(
            StoryModel.story.length,
            (index) {
              StoryModel storyModel = StoryModel.story[index];
              return UsersStory(storyModel: storyModel);
            },
          ),
        ],
      ),
    );
  }
}
