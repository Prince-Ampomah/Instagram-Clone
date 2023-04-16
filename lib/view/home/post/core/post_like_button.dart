import 'package:flutter/material.dart';

import '../../../../controller/post_controller/like_controller.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/services/hive_services.dart';
import '../../../../model/post_model/post_model.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
    required this.postId,
    this.postModel,
  });

  final String postId;
  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    String? userId = HiveServices.getUserBox().get(Const.currentUser)?.userId;

    return GestureDetector(
      onTap: () async {
        LikeController.instance.togglePostLike(postId);
      },
      onDoubleTap: () {
        LikeController.instance.togglePostLike(postId);
      },
      child: Icon(
        postModel!.isLikedBy!.contains(userId)
            ? Icons.favorite
            : Icons.favorite_outline_rounded,
        color: postModel!.isLikedBy!.contains(userId) ? Colors.red : null,
        size: 28,
      ),
    );
  }
}
