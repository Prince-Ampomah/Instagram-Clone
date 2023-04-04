import 'package:flutter/material.dart';

import '../../../model/story_model/story_model.dart';

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
        Container(
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
              colors: [
                Colors.orange,
                Colors.pink,
                Colors.purple,
              ],
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image.asset(storyModel.userProfileImage!),
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
