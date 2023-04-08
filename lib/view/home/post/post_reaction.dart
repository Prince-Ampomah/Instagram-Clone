// import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/view/comments/comment_view.dart';
import 'package:instagram_clone/view/home/post/core/post_comment_button.dart';
import 'package:instagram_clone/view/home/post/core/post_like_button.dart';
import 'package:instagram_clone/view/home/post/core/post_save_button.dart';
import 'package:instagram_clone/view/home/post/core/post_send_message_button.dart';

import '../../../core/constants/constants.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/utils/date_time_convertor.dart';
import '../../../core/widgets/cus_rich_text.dart';
import '../../../model/post_model/post_model.dart';
import '../../../model/user_model/user_model.dart';

class PostReaction extends StatelessWidget {
  const PostReaction({super.key, this.postModel, this.userModel});

  final PostModel? postModel;
  final UserModel? userModel;

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
                  CommentButton(onTap: sendToCommentView),
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
              text1: '${userModel!.userHandle} ',
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
              DateTimeConvertor.getTimeAgo(postModel!.timePosted!),
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
        userImage: userModel!.profileImage,
        userHandle: userModel!.userHandle,
        caption: postModel!.caption,
        timePosted: postModel!.timePosted,
      ),
    );
  }
}
