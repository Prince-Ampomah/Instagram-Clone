import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/cus_main_button.dart';
import '../../../../model/user_model/user_model.dart';
import '../../edit_profile/edit_profile_view.dart';

class CurrentUserEditAndShareProfile extends StatelessWidget {
  const CurrentUserEditAndShareProfile({
    super.key,
    required this.userModel,
  });

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // edit profile
          PrimaryButton(
            onPressed: () {
              Get.to(() => EditProfileView(userInfo: userModel));
            },
            buttonHeight: 34,
            title: 'Edit profile',
            fontWeight: FontWeight.bold,
            foregroundColor: Colors.black,
            bgColor: AppColors.buttonBgColor,
            borderRadius: 8,
          ),

          const SizedBox(width: 10),

          // share profile
          PrimaryButton(
            onPressed: () {},
            buttonHeight: 34,
            title: 'Share profile',
            fontWeight: FontWeight.bold,
            foregroundColor: Colors.black,
            bgColor: AppColors.buttonBgColor,
            borderRadius: 8,
          ),

          const Spacer(),

          // icon
          Container(
            width: 50,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.person_add_outlined,
              size: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
