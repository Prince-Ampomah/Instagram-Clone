import 'package:flutter/material.dart';

import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/theme/theme.dart';
import 'package:instagram_clone/core/widgets/cus_bottom_sheet.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/core/widgets/cus_read_more_text.dart';
import 'package:instagram_clone/core/widgets/cus_rich_text.dart';
import 'package:instagram_clone/view/reel/reel_comment_list.dart';

import '../../controller/post_controller/comment_controller.dart';
import '../../core/utils/date_time_convertor.dart';
import '../../model/user_model/user_model.dart';
import '../comments/comment_text_field.dart';

class ReelCommentBottomSheet extends StatelessWidget {
  const ReelCommentBottomSheet({
    Key? key,
    this.reelCaption,
    this.reelPostedTime,
    required this.reelUser,
    required this.reelId,
  }) : super(key: key);

  final String reelId;
  final String? reelCaption;
  final DateTime? reelPostedTime;
  final UserModel reelUser;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetContainer(
      height: 0.75,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  20.ph,
                  Text(
                    'Comments',
                    style: AppTheme.textStyle(context).labelLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  10.ph,
                  const Divider(
                    color: Colors.black87,
                    thickness: 1.3,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  if (reelCaption != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (reelUser.profileImage != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CustomCachedImage(
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                imageUrl: reelUser.profileImage!,
                              ),
                            ),
                          20.pw,
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomRichText(
                                    text1: reelUser.userHandle ?? '',
                                    text2:
                                        ' ${DateTimeConvertor.getTimeAgo(reelPostedTime!)}',
                                    text1Style: AppTheme.textStyle(context)
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    text2Style: AppTheme.textStyle(context)
                                        .titleSmall!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                  ),
                                  10.ph,
                                  CustomReadMore(text: reelCaption!),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Divider(thickness: 0.3),
                  ReelCommentListView(reelId: reelId),
                ],
              ),
            ),
            CommentTextField(
              onSaved: (value) {
                CommentController.commentTextFieldController.text =
                    value!.trim();
              },
              onFieldSubmitted: (value) async {
                CommentController.commentTextFieldController.text =
                    value.trim();
                await CommentController.instance.sendReelComment(reelId);
              },
              onPostTap: () async {
                await CommentController.instance.sendReelComment(reelId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
