import 'package:flutter/material.dart';
import 'package:instagram_clone/model/feed_model/feed_model.dart';

import '../../../controller/auth_controller/auth_controller.dart';
import '../../../core/constants/constants.dart';
import 'core/feed_reaction.dart';
import 'core/feed_user.dart';
import 'image/feed_image.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({
    super.key,
    this.feedModel,
  });

  final FeedModel? feedModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FeedUser(
          image: feedModel!.userModel!.profileImage,
          userHandle: feedModel!.userModel!.userHandle,
        ),
        FeedImage(
          images: feedModel!.media,
          image: feedModel!.media.first,
        ),
        FeedReaction(
          likeModel: feedModel!.likeModel!,
          userHandle: feedModel!.userModel!.userHandle,
          caption: feedModel!.caption!,
        ),
      ],
    );
  }
}
