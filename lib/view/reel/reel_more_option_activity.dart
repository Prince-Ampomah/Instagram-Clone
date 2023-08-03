import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/widgets/cus_list_tile.dart';
import 'package:ionicons/ionicons.dart';

import '../../core/widgets/cus_bottom_sheet.dart';
import '../../model/user_model/user_model.dart';
import '../home/post/post_current_user_bottomsheet_activity.dart';

class ReelActivity extends StatelessWidget {
  const ReelActivity({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetContainer(
      height: 0.56,
      child: Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            10.ph,
            // save and QR code
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PostActivityCircularButton(
                  onTap: () {
                    Navigator.pop(context);
                    // SavePostController.instance.savePost(postModel!.id!?);
                  },
                  text: 'Save',
                  icon: Icons.bookmark_outline,
                ),
                PostActivityCircularButton(
                  onTap: () {},
                  text: 'Remix',
                  icon: Ionicons.add_outline,
                ),
                PostActivityCircularButton(
                  onTap: () {},
                  text: 'Sequence',
                  icon: Ionicons.journal_outline,
                ),
              ],
            ),

            10.ph,
            const Divider(thickness: 0.7),
            10.ph,

            //why you see the post
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Ionicons.notifications_outline,
                color: Colors.black,
                size: 30,
              ),
              title: 'Turn on Reels notifications',
            ),

            const Divider(thickness: 0.7),

            10.ph,

            //why you see the post
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.info_outline_rounded,
                color: Colors.black,
                size: 30,
              ),
              title: "Why you're seeing this post",
            ),

            10.ph,

            // hide
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.visibility_off,
                color: Colors.black,
                size: 30,
              ),
              title: "Not Interested",
            ),
            10.ph,

            // report
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.report_gmailerrorred_outlined,
                color: Colors.red,
                size: 30,
              ),
              title: 'Report',
              titleStyle: const TextStyle(color: Colors.red),
            ),
            10.ph,
            const Divider(),
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Ionicons.options_outline,
                size: 30,
              ),
              title: 'Manage suggested content',
              // titleStyle: const TextStyle(color: Colors.red),
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}
