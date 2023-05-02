import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/post_controller/post_controller.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:instagram_clone/core/utils/utils.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';
import 'dart:math' as math;

import '../../../controller/post_controller/save_controller.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/widgets/cus_bottom_sheet.dart';
import '../../../core/widgets/cus_list_tile.dart';

class PostCurrentUserBottomSheetActivity extends StatelessWidget {
  const PostCurrentUserBottomSheetActivity({
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

            // favorites
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.restore,
                color: Colors.black,
                size: 30,
              ),
              title: 'Archive',
            ),
            5.ph,

            // hide or unhide like count
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.favorite_border,
                color: Colors.black,
                size: 30,
              ),
              title: 'Hide like count',
            ),

            5.ph,

            // turn of comments
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.motion_photos_off_outlined,
                color: Colors.black,
                size: 30,
              ),
              title: 'Turn off commenting',
            ),
            5.ph,

            // edit
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.edit_outlined,
                color: Colors.black,
                size: 30,
              ),
              title: 'Edit',
            ),
            5.ph,

            // pin profile
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: Transform.rotate(
                angle: 180 / math.pi,
                child: const Icon(
                  Icons.push_pin_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              title: 'Pin to your profile',
            ),
            5.ph,

            // share post
            CustomListTile(
              onTap: () {},
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.share_outlined,
                color: Colors.black,
                size: 30,
              ),
              title: 'Post to other apps...',
            ),
            5.ph,

            // delete post
            CustomListTile(
              onTap: () async {
                Navigator.pop(context);
                Utils.dialog(
                  context,
                  onTap: () async {
                    await PostController.instance.deletePost(postModel!.id!);
                  },
                  content:
                      'You can restore this post from Recently deleted in Your Activity withing 30 days. After that, it will be permanently deleted.',
                );
              },
              minLeadingWidth: 20,
              leading: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 30,
              ),
              title: 'Delete',
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
                icon,
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
