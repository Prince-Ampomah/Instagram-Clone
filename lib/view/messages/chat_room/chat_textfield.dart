import 'package:flutter/material.dart';

import '../../../controller/chat_controller/chat_controller.dart';
import '../../../core/theme/app_colors.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 5.0, 5, 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.buttonBgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
            ),
          ),
          Flexible(
            child: TextField(
              focusNode: ChatController.chatTextFieldFocus,
              controller: ChatController.chatTextController,
              maxLines: 7,
              minLines: 1,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.newline,
              textAlign: TextAlign.justify,
              cursorColor: AppColors.blackColor,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8),
                border: InputBorder.none,
                hintText: 'Message...',
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              ChatController.instance.sendTextMessage();
            },
            icon: const Icon(
              Icons.send,
              size: 27,
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.mic_none_outlined,
          //     size: 27,
          //   ),
          // ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.image_outlined,
          //     size: 27,
          //   ),
          // ),
        ],
      ),
    );
  }
}
