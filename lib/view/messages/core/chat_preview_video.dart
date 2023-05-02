import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';

import '../../../controller/chat_controller/chat_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/cus_video_player.dart';
import 'chat_media_preview_send_button.dart';

class ChatPreviewVideo extends StatelessWidget {
  const ChatPreviewVideo({
    super.key,
    required this.videoPath,
    this.showSendButton = false,
  });

  final String videoPath;
  final bool? showSendButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CusVideoPlayer(videoPath: videoPath),
            10.ph,
            if (showSendButton!)
              MediaPreviewSendButton(
                onTap: () {
                  ChatController.instance.sendMediaMessage(Const.videoType);
                  popUntil(context, 2);
                },
              ),
          ],
        ),
      ),
    );
  }
}
