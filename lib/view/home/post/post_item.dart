import 'package:flutter/material.dart';
import 'package:instagram_clone/view/home/post/post_video.dart';

import '../../../core/constants/constants.dart';
import '../../../model/post_model/post_model.dart';
import '../../../model/user_model/user_model.dart';
import '../../../repository/respository_implementation/database_implementation.dart';
import 'post_image.dart';
import 'post_reaction.dart';
import 'post_user.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    this.postModel,
  });

  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreDBImpl.getUserData(postModel!.userId!),
      builder: (
        BuildContext context,
        AsyncSnapshot<UserModel> userModelsnapshot,
      ) {
        if (userModelsnapshot.hasData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PostUser(
                userModel: userModelsnapshot.data,
                postModel: postModel,
              ),
              if (postModel?.postType == Const.videoPostType)
                PostVideoView(
                  video: postModel!.media,
                  postModel: postModel,
                )
              else
                PostImage(
                  images: postModel!.media,
                  postModel: postModel,
                ),
              PostReaction(
                postModel: postModel,
                userModel: userModelsnapshot.data,
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
