import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/view/home/story/new_story_camera_view.dart';

import '../../../core/constants/constants.dart';
import '../../add_post/add_new_post_camera_view.dart';

class CurrentUserStory extends StatelessWidget {
  const CurrentUserStory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            sendToPage(context, const NewStoryPostCameraView());
          },
          child: Stack(
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
