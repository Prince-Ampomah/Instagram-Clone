import 'package:flutter/material.dart';

import '../../controller/post_controller/comment_controller.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/cus_circular_image.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.16,
      child: Column(
        children: [
          const Divider(),
          Expanded(
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: CircularImageContainer(
                    border: Border.all(width: 0.5),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: CommentController.commentTextFieldController,
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
