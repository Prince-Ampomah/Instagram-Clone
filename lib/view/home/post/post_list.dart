import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/view/home/post/post_item.dart';

class PostList extends StatelessWidget {
  const PostList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: PostModel.posts.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == PostModel.posts.length) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Center(
              child: CustomCircularProgressBar(),
            ),
          );
        } else {
          PostModel postModel = PostModel.posts[index];

          return PostItem(postModel: postModel);
        }
      },
    );
  }
}
