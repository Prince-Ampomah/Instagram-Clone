import 'package:flutter/material.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';

import 'core/post_reaction.dart';
import 'core/post_user.dart';
import 'core/post_image.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    this.postModel,
  });

  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostUser(
          image: postModel!.userModel!.profileImage,
          userHandle: postModel!.userModel!.userHandle,
        ),
        PostImage(
          images: postModel!.media,
        ),
        PostReaction(
          likeModel: postModel!.likeModel,
          userHandle: postModel!.userModel!.userHandle,
          caption: postModel!.caption,
        ),
      ],
    );
  }
}
