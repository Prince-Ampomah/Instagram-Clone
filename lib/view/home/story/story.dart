import 'package:flutter/material.dart';

import 'current_user_story/current_user_story.dart';
import 'other_stories/others_story_list.dart';

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
        children: const [
          CurrentUserStory(),
          OthersStoryList(),
        ],
      ),
    );
  }
}
