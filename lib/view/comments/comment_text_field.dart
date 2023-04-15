import 'package:flutter/material.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';

import '../../controller/post_controller/comment_controller.dart';
import '../../core/constants/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cus_circular_image.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    UserModel? userModel = HiveServices.getUserBox().get(Const.currentUser);

    return SizedBox(
      height: size.height * 0.15,
      child: Column(
        children: [
          const Divider(),
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: userModel?.profileImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CustomCachedImage(
                            height: 35,
                            width: 35,
                            imageUrl: userModel!.profileImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : CircularImageContainer(
                          border: Border.all(width: 0.5),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: CommentController.commentTextFieldController,
                    focusNode: CommentController.commentTextFiedFocus,
                    maxLines: 50,
                    minLines: 1,
                    textInputAction: TextInputAction.send,
                    cursorColor: AppColors.blackColor,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add a comment...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onSaved: (value) {
                      CommentController.commentTextFieldController.text =
                          value!.trim();
                    },
                    onFieldSubmitted: (value) async {
                      CommentController.commentTextFieldController.text =
                          value.trim();
                      await CommentController.instance.sendComment();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                  child: GestureDetector(
                    onTap: () async {
                      await CommentController.instance.sendComment();
                    },
                    child: const Text(
                      'Post',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
