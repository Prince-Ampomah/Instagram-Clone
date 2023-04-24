import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../controller/chat_controller/chat_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/cus_cached_image.dart';
import 'chat_media_preview_back_button.dart';
import 'chat_media_preview_indicator.dart';
import 'chat_media_preview_send_button.dart';

class ChatImagePreview extends StatelessWidget {
  const ChatImagePreview({super.key, this.isFromGallery = true});

  final bool isFromGallery;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.blackColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: ChatController.instance.chatMedia!.length,
                    onPageChanged: ChatController.instance.onPageChanged,
                    itemBuilder: (context, index) {
                      return CustomCachedImage(
                        imageUrl: ChatController.instance.chatMedia![index]!,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  const ChatMediaPreviewBackButton(),
                  if (ChatController.instance.chatMedia!.length != 1)
                    const ChatMediaPreviewIndicator(),
                ],
              ),
            ),
            10.ph,
            ChatMediaPreviewSendButton(
              onTap: () {
                ChatController.instance.sendMediaMessage(Const.imageType);

                if (isFromGallery) {
                  Navigator.pop(context);
                } else {
                  popUntil(context, 2);
                }
              },
              isFromGallery: isFromGallery,
            ),
          ],
        ),
      ),
    );
  }
}
