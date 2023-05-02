import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/chat_controller/chat_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_smooth_page_indicator.dart';

class MeidaPreviewIndicator extends StatelessWidget {
  const MeidaPreviewIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GetBuilder<ChatController>(
          builder: (_) {
            return CustomSmoothIndicator(
              count: ChatController.instance.chatMedia!.length,
              activeIndex: ChatController.instance.countImagePreview,
              activeDotColor: AppColors.buttonColor,
              dotColor: AppColors.buttonBgColor,
            );
          },
        ),
      ),
    );
  }
}
