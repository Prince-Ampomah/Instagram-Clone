import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/chat_controller/chat_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/cus_appbar.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_main_button.dart';
import '../../../core/widgets/cus_smooth_page_indicator.dart';

class ChatImagePreview extends StatelessWidget {
  const ChatImagePreview({super.key, this.isFromGallery = true});

  final bool isFromGallery;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        leadingIcon: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.clear, size: 30),
        ),
        title: 'Preview',
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: ChatController.instance.chatMedia!.length,
                onPageChanged: ChatController.instance.onPageChanged,
                itemBuilder: (context, index) {
                  return CustomCachedImage(
                    imageUrl: ChatController.instance.chatMedia![index]!,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            10.ph,
            if (ChatController.instance.chatMedia!.length != 1)
              GetBuilder<ChatController>(
                builder: (_) {
                  return CustomSmoothIndicator(
                    count: ChatController.instance.chatMedia!.length,
                    activeIndex: ChatController.instance.countImagePreview,
                    activeDotColor: AppColors.buttonColor,
                    dotColor: AppColors.buttonBgColor,
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 20),
              child: MainButton(
                onPressed: () {
                  ChatController.instance.sendImageMessage();

                  if (isFromGallery) {
                    Navigator.pop(context);
                  } else {
                    popUntil(context, 2);
                  }
                },
                title: 'Send',
                bgColor: AppColors.buttonColor,
                textColor: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
