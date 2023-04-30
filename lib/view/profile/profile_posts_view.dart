import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_appbar.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';

import '../../core/constants/constants.dart';
import '../home/post/post_image.dart';
import '../home/post/post_reaction.dart';
import '../home/post/post_user.dart';
import '../home/post/post_video.dart';

class ProfilePost extends StatelessWidget {
  const ProfilePost(
      {super.key, required this.userModel, required this.postModel});

  final UserModel userModel;
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Posts',
      ),
      body: ListView(
        children: [
          Column(
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
          )
        ],
      ),
    );
  }
}
