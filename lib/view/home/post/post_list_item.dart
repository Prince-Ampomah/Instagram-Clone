import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/view/home/post/post_item.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    super.key,
    // this.postController,
    this.snapshot,
  });

  // final PostController? postController;

  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: snapshot!.data!.docs.length + 1,
      // postController!.getPostList!.length + 1,
      itemBuilder: (BuildContext context, int index) {
        // postController.getPostList!.length
        if (index == snapshot!.data!.docs.length) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Center(
              child: CustomCircularProgressBar(),
            ),
          );
        } else {
          // postController.getPostList![index].data()
          PostModel postModel =
              PostModel.fromJson(snapshot!.data!.docs[index].data());

          return PostItem(postModel: postModel);
        }
      },
    );
  }
}
