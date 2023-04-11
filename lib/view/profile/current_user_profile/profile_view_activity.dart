import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/view/authentication/sign_in_view/sign_in_view.dart';

import '../../../controller/auth_controller/auth_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/cus_bottom_sheet.dart';

class ProfileActivity extends StatelessWidget {
  const ProfileActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetContainer(
      height: 1.0,
      child: Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            ActivityListItem(
              onTap: () async {
                await AuthController.instance.signOutUser();
                await HiveServices.getUserBox()
                    .delete(Const.currentUser)
                    .whenComplete(
                      () => Get.offAll(() => const SignInView()),
                      // noReturnPushReplacement(
                      //   context,
                      //   const SignInView(),
                      // ),
                    );
              },
              iconData: Icons.logout,
              text: 'Logout',
            ),
            ActivityListItem(
              onTap: () {
                showToast(msg: 'ss');
              },
              iconData: Icons.settings,
              text: 'Settings',
            ),
            ActivityListItem(
              onTap: () {},
              iconData: Icons.access_time,
              text: 'Your activity',
            ),
            ActivityListItem(
              onTap: () {},
              iconData: Icons.archive,
              text: 'Archive',
            ),
            ActivityListItem(
              onTap: () {},
              iconData: Icons.qr_code_2_outlined,
              text: 'QR code',
            ),
            ActivityListItem(
              onTap: () {},
              iconData: Icons.bookmark_outline,
              text: 'Saved',
            ),
            ActivityListItem(
              onTap: () {},
              iconData: Icons.payment_outlined,
              text: 'Orders and payments',
            ),
            ActivityListItem(
              onTap: () {},
              iconData: Icons.check_circle_outline_outlined,
              text: 'Digital collectibles',
            ),
            ActivityListItem(
              onTap: () {},
              iconData: Icons.menu_sharp,
              text: 'Close Friends',
            ),
            ActivityListItem(
              onTap: () {},
              iconData: Icons.star_border,
              text: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({
    super.key,
    this.onTap,
    required this.iconData,
    required this.text,
  });

  final Function()? onTap;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        onTap: onTap,
        minLeadingWidth: 20,
        leading: Icon(
          iconData,
          size: 27,
          color: const Color.fromARGB(255, 27, 27, 27),
        ),
        title: Text(
          text,
          style: AppTheme.textStyle(context).titleMedium!.copyWith(
                fontSize: 16,
              ),
        ),
      ),
    );
  }
}
