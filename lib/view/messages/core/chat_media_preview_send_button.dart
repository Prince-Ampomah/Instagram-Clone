import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';

import '../../../controller/chat_controller/chat_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_circular_image.dart';

class ChatMediaPreviewSendButton extends StatelessWidget {
  const ChatMediaPreviewSendButton({
    super.key,
    this.isFromGallery = false,
    required this.onTap,
  });

  final bool? isFromGallery;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        margin: const EdgeInsets.fromLTRB(5, 3, 10, 25),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            ChatController.instance.receiverModel!.profileImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CustomCachedImage(
                      imageUrl:
                          ChatController.instance.receiverModel!.profileImage!,
                      height: 25,
                      width: 25,
                      fit: BoxFit.cover,
                    ),
                  )
                : CircularImageContainer(
                    height: 0.03,
                    width: 0.03,
                    border: Border.all(width: .5),
                  ),
            8.pw,
            const Text(
              'Send',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
