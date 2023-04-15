import 'package:flutter/material.dart';

import '../../controller/follow_controller/follow_controller.dart';

class UnfollowButton extends StatelessWidget {
  const UnfollowButton({
    super.key,
    required this.userToUnfollowId,
  });

  final String? userToUnfollowId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FollowController.instance.unFollowUser(userToUnfollowId!);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Unfollow',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
