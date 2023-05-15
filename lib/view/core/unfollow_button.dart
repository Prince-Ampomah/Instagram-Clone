import 'package:flutter/material.dart';

import '../../controller/follow_controller/follow_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cus_main_button.dart';

class UnfollowButton extends StatelessWidget {
  const UnfollowButton({
    super.key,
    required this.userToUnfollowId,
  });

  final String? userToUnfollowId;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      buttonHeight: 36,
      // buttonWidth: 120,
      onPressed: () {
        FollowController.instance.unFollowUser(userToUnfollowId!);
      },
      title: 'Unfollow',
      fontWeight: FontWeight.bold,
      textColor: Colors.black,
      foregroundColor: Colors.black,
      bgColor: AppColors.buttonBgColor,
      borderRadius: 8,
    );
  }
}
