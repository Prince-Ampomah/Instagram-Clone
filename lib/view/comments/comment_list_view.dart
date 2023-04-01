import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/post_controller/comment_controller.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/view/comments/comment_list_item_view.dart';

import '../../core/constants/constants.dart';
import '../../core/widgets/cus_circular_progressbar.dart';

class CommentListView extends StatelessWidget {
  const CommentListView({super.key});

  @override
  Widget build(BuildContext context) {
    String postId = HiveServices.getPostId();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection(Const.commentsCollection)
          .where('postId', isEqualTo: postId)
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomCircularProgressBar());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No comment yet!'));
        }

        if (snapshot.hasData) {
          return CommentListItemView(snapshot: snapshot);
        }

        return Center(child: Text('Something went wrong: ${snapshot.error}'));
      },
    );

    // return GetBuilder<CommentController>(builder: (controller) {
    //   if (controller.waiting) {
    //     return const Center(
    //       child: CustomCircularProgressBar(),
    //     );
    //   }

    //   if (controller.hasError) {
    //     return Center(
    //       child: Text(controller.getTextState),
    //     );
    //   }

    //   if (controller.hasData) {
    //     return const CommentListItemView();
    //   }

    //   return Center(child: Text(controller.getTextState));
    // });
  }
}
