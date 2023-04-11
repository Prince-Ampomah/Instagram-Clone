import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';

import '../../../controller/follow_controller/follow_controller.dart';
import '../../../controller/post_controller/save_controller.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/widgets/cus_bottom_sheet.dart';
import '../../../core/widgets/cus_list_tile.dart';

class PostUserBottomSheetActivity extends StatelessWidget {
  const PostUserBottomSheetActivity({
    super.key,
    this.postModel,
    this.userModel,
  });

  final PostModel? postModel;
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    var currentUser = HiveServices.getUserBox().get(Const.currentUser);

    return CustomBottomSheetContainer(
      height: 0.68,
      child: Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            // save and QR code
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PostActivityCircularButton(
                  onTap: () {
                    Navigator.pop(context);
                    SavePostController.instance.savePost(postModel!.id!);
                  },
                  text: postModel!.isSavedBy!.contains(currentUser!.userId)
                      ? 'Saved'
                      : 'Save',
                  icon: postModel!.isSavedBy!.contains(currentUser.userId)
                      ? Icons.bookmark
                      : Icons.bookmark_outline,
                ),
                PostActivityCircularButton(
                  onTap: () {},
                  text: 'QR code',
                  icon: Icons.qr_code_scanner_outlined,
                ),
              ],
            ),
            10.ph,
            const Divider(thickness: 0.7),
            5.ph,

            // share link
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: SizedBox(
                height: 22,
                child: Image.asset(
                  Const.instragramSendIcon,
                  color: Colors.black,
                ),
              ),
              title: "We're moving things around",
              subTitle: 'See where to share and link',
              subTitleStyle: const TextStyle(
                color: AppColors.buttonColor,
              ),
            ),
            const Divider(thickness: 0.7),
            5.ph,

            // favorites
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.star_border,
                color: Colors.black,
                size: 30,
              ),
              title: 'Add to favorites',
            ),
            5.ph,

            // follow or unfollow
            CustomListTile(
              onTap: userModel!.listOfFollowers!.contains(currentUser.userId)
                  ? () {
                      FollowController.instance
                          .unFollowUser(postModel!.userId!);
                    }
                  : () {
                      FollowController.instance.followUser(postModel!.userId!);
                    },
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.person_remove_outlined,
                color: Colors.black,
                size: 30,
              ),
              title: userModel!.listOfFollowers!.contains(currentUser.userId)
                  ? 'Unfollow'
                  : 'Follow',
            ),
            const Divider(thickness: 0.7),
            5.ph,

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
            5.ph,

            // hide
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.visibility_off,
                color: Colors.black,
                size: 30,
              ),
              title: "Hide",
            ),
            5.ph,

            // about this account
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.account_circle_outlined,
                color: Colors.black,
                size: 30,
              ),
              title: 'About this account',
            ),
            5.ph,

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
            5.ph,
          ],
        ),
      ),
    );
  }
}

class PostActivityCircularButton extends StatelessWidget {
  const PostActivityCircularButton({
    super.key,
    required this.text,
    this.onTap,
    required this.icon,
  });

  final String text;
  final Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon, //Icons.qr_code_scanner_outlined,
                size: 30,
              ),
            ),
          ),
        ),
        10.ph,
        Text(text)
      ],
    );
  }
}
