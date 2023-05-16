import 'package:flutter/material.dart';

import '../../controller/follow_controller/follow_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cus_main_button.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
    required this.userToFollowerId,
  });

  final String? userToFollowerId;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      buttonHeight: 36,
      // buttonWidth: 120,
      onPressed: () {
        FollowController.instance.followUser(userToFollowerId!);
      },
      title: 'Follow',
      fontWeight: FontWeight.bold,
      textColor: AppColors.whiteColor,
      foregroundColor: Colors.black,
      bgColor: AppColors.buttonColor,
      borderRadius: 8,
    );
  }
}
