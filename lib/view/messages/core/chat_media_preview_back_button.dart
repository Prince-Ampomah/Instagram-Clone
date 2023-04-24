import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ChatMediaPreviewBackButton extends StatelessWidget {
  const ChatMediaPreviewBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.whiteColor,
            size: 27,
          ),
        ),
      ),
    );
  }
}
