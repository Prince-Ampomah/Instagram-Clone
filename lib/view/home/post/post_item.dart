import 'package:flutter/material.dart';

import '../../../model/post_model/post_model.dart';
import 'post_image.dart';
import 'post_reaction.dart';
import 'core/post_user.dart';

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
          postModel: postModel,
        ),
        PostReaction(postModel: postModel),
      ],
    );
  }
}
