import 'package:flutter/material.dart';

import '../../controller/post_controller/comment_controller.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/cus_appbar.dart';
import 'comment_list_view.dart';
import 'comment_post_header.dart';
import 'comment_text_field.dart';

class CommentView extends StatelessWidget {
  const CommentView({
    super.key,
    this.caption,
    this.userHandle,
    this.userImage,
    this.timePosted,
  });

  final String? caption, userHandle, userImage;
  final DateTime? timePosted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Comments',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SizedBox(
              height: 22,
              child: Image.asset(
                Const.instragramSendIcon,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                CommentPostHeader(
                  userImage: userImage,
                  userHandle: userHandle,
                  timePosted: timePosted,
                  caption: caption,
                ),
                const Divider(thickness: 0.5),
                const CommentListView(),
              ],
            ),
          ),

          // comment text field
          const CommentTextField()
        ],
      ),
    );
  }
}
