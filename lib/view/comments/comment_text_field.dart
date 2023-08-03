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
    this.onSaved,
    this.onFieldSubmitted,
    this.onPostTap,
  });

  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final Function()? onPostTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    UserModel? userModel = HiveServices.getUserBox().get(Const.currentUser);

    return SizedBox(
      height: size.height * 0.17,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(thickness: 0.3, height: 0.0),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  emojis.length,
                  (index) => GestureDetector(
                    onTap: () {
                      CommentController.commentTextFieldController.text =
                          emojis[index];
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        emojis[index],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(thickness: 0.3, height: 0.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
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
                      onSaved: onSaved,
                      onFieldSubmitted: onFieldSubmitted,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: GestureDetector(
                      onTap: onPostTap,
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
          ),
        ],
      ),
    );
  }
}

List<String> emojis = [
  '💖',
  '🙌',
  '🔥',
  '👏',
  '😪',
  '😍',
  '😨',
  '😂',
];
