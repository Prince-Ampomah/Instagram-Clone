import 'package:flutter/material.dart';
import 'package:instagram_clone/controller/post_controller/post_controller.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/view/home/post/post_item.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    super.key,
    required this.postController,
  });

  final PostController postController;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: postController.getPostList!.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == postController.getPostList!.length) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Center(
              child: CustomCircularProgressBar(),
            ),
          );
        } else {
          PostModel postModel =
              PostModel.fromJson(postController.getPostList![index].data());

          return PostItem(postModel: postModel);
        }
      },
    );
  }
}
