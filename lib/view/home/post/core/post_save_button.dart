import 'package:flutter/material.dart';

import '../../../../controller/post_controller/save_controller.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/services/hive_services.dart';
import '../../../../model/post_model/post_model.dart';

class SavePostButton extends StatelessWidget {
  const SavePostButton({
    super.key,
    this.postModel,
  });

  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    String? userId = HiveServices.getUserBox().get(Const.currentUser)?.userId;
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
        color: Colors.black,
        size: 28,
      ),
    );
  }
}
