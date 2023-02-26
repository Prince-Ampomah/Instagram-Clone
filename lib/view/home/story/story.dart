import 'package:flutter/material.dart';
import 'package:instagram_clone/model/story_model/story_model.dart';

import '../../../core/constants/constants.dart';

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
        children: List.generate(
          StoryModel.story.length,
          (index) {
            if (index == 0) {
              // your story
              return const YourStory();
            } else {
              StoryModel storyModel = StoryModel.story[index];
              // other stories
              return OtherStories(
                storyModel: storyModel,
              );
            }
          },
        ),
      ),
    );
  }
}

class YourStory extends StatelessWidget {
  const YourStory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 75,
              width: 75,
              margin: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 0.1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.asset(Const.princeImage),
              ),
            ),
            Positioned(
              top: size.height * 0.07,
              left: size.width * 0.17,
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Text(
            'userHandle',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class OtherStories extends StatelessWidget {
  const OtherStories({
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
