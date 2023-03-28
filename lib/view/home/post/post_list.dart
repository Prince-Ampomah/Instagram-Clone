import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/cus_circular_progressbar.dart';
import 'post_list_item.dart';

import '../../../controller/post_controller/post_controller.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      builder: (controller) {
        if (controller.waiting) {
          return const Center(
            child: CustomCircularProgressBar(),
          );
        }

        if (controller.hasError) {
          return Center(
            child: Text(controller.getTextState),
          );
        }

        if (controller.hasData) {
          return PostListItem(postController: controller);
        }

        return Center(child: Text(controller.getTextState));
      },
    );
  }
}
