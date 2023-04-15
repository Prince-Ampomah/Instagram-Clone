import 'package:flutter/material.dart';

import '../../controller/follow_controller/follow_controller.dart';
import '../../core/theme/app_colors.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
    required this.userToFollowerId,
  });

  final String? userToFollowerId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FollowController.instance.followUser(userToFollowerId!);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Follow',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
