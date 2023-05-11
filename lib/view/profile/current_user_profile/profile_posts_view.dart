import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_appbar.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';

import '../../../controller/profile_controller/post_profile_controller.dart';
import '../../../core/constants/constants.dart';
import '../../home/post/post_image.dart';
import '../../home/post/post_reaction.dart';
import '../../home/post/post_user.dart';
import '../../home/post/post_video.dart';

class UserProfilePostView extends StatelessWidget {
  const UserProfilePostView({
    super.key,
    required this.userModel,
    required this.profileController,
  });

  final UserModel userModel;
  final PostProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        implyLeading: true,
        title: 'Posts',
      ),
      body: ListView.builder(
        itemCount: profileController.getPostProfileList!.length,
        itemBuilder: (BuildContext context, int index) {
          PostModel postModel = PostModel.fromJson(
              profileController.getPostProfileList![index].data());
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PostUser(
                  userModel: userModel,
                  postModel: postModel,
                ),
                postModel.postType == Const.videoPostType
                    ? PostVideoView(
                        video: postModel.media,
                        postModel: postModel,
                      )
                    : PostImage(
                        images: postModel.media,
                        postModel: postModel,
                      ),
                PostReaction(
                  postModel: postModel,
                  userModel: userModel,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
