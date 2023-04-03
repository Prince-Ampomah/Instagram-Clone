// import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/post_controller/save_controller.dart';
import 'package:instagram_clone/view/comments/comment_view.dart';

import '../../../../controller/post_controller/like_controller.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/services/hive_services.dart';
import '../../../../core/utils/date_time_convertor.dart';
import '../../../../core/widgets/cus_rich_text.dart';
import '../../../../model/post_model/post_model.dart';

class PostReaction extends StatelessWidget {
  const PostReaction({super.key, this.postModel});

  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // like, comment, message and save icons widget
          Row(
            children: [
              Row(
                children: [
                  LikeButton(
                    postModel: postModel,
                    postId: postModel!.id!,
                  ),
                  23.pw,
                  GestureDetector(
                    onTap: sendToCommentView,
                    child: SizedBox(
                      height: 22,
                      child: Image.asset(
                        Const.instragramCommentIcon,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  23.pw,
                  const SendMessageButton(),
                ],
              ),
              const Spacer(),
              SavePostButton(postModel: postModel)
            ],
          ),

          10.ph,

          // users like widget
          if (postModel!.like != 0)
            Text(
              postModel!.like == 1
                  ? '${postModel!.like} Like'
                  : '${postModel!.like} Likes',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

          8.ph,

          // caption widget
          if (postModel!.caption!.isNotEmpty)
            CustomRichText(
              text1: '${postModel!.userModel!.userHandle} ',
              text2: postModel!.caption,
              text1Style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

          8.ph,

          // comments
          if (postModel!.comment != 0)
            GestureDetector(
              onTap: sendToCommentView,
              child: Text(
                postModel!.comment! == 1
                    ? 'View ${postModel!.comment} comment'
                    : 'View all ${postModel!.comment} comments',
                style: const TextStyle(color: Colors.grey),
              ),
            ),

          10.ph,

          // posted time
          if (postModel!.timePosted != null)
            Text(
              DateTimeConvertor.getFormattedMonthAndDay(postModel!.timePosted!),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
        ],
      ),
    );
  }

  void sendToCommentView() {
    HiveServices.savePostId(postModel!.id!);

    Get.to(
      () => CommentView(
        userImage: postModel!.userModel!.profileImage,
        userHandle: postModel!.userModel!.userHandle,
        caption: postModel!.caption,
        timePosted: postModel!.timePosted,
      ),
    );
  }
}

class SavePostButton extends StatelessWidget {
  const SavePostButton({
    super.key,
    this.postModel,
  });

  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    String? userId = HiveServices.getUserBox().get(Const.currentUser)!.userId;
    return IconButton(
      onPressed: () {
        SavePostController.instance.savePost(postModel!.id!);
      },
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
      icon: Icon(
        postModel!.isSavedBy!.contains(userId)
            ? Icons.bookmark
            : Icons.bookmark_border,
        size: 28,
      ),
    );
  }
}

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
    String? userId = HiveServices.getUserBox().get(Const.currentUser)!.userId;

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

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      child: Image.asset(
        Const.instragramSendIcon,
        color: Colors.black,
      ),
    );
  }
}

// class CommentButton extends StatelessWidget {
//   const CommentButton({
//     super.key,
//     this.caption,
//     this.userHandle,
//     this.timePosted,
//   });

//   final String? caption, userHandle;
//   final DateTime? timePosted;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(() => CommentView(
//               userHandle: userHandle,
//               caption: caption,
//               timePosted: timePosted,
//             ));
//       },
//       child: SizedBox(
//         height: 22,
//         child: Image.asset(
//           Const.instragramCommentIcon,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }
