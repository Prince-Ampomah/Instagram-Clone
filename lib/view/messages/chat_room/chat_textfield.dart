import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/view/camera/camera_view.dart';
import 'package:instagram_clone/view/messages/chat_room/pick_images_option.dart';
import 'package:instagram_clone/view/messages/core/chat_preview_image.dart';

import '../../../controller/chat_controller/chat_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_bottom_sheet.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_list_tile.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({
    super.key,
  });

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  @override
  void initState() {
    super.initState();
    ChatController.instance.addListenerToChatTextField();
  }

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
          GestureDetector(
            onTap: () {
              sendToPage(context, const CameraView());
            },
            child: Container(
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
          GetBuilder<ChatController>(
            builder: (chatController) {
              if (chatController.isTyping &&
                  ChatController.chatTextController.text.trim().isNotEmpty) {
                return GestureDetector(
                  onTap: () {
                    chatController.sendTextMessage();
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 8, 15, 8),
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: AppColors.chatColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              } else {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showToast(msg: 'record');
                      },
                      child: const Icon(
                        Icons.mic_none_outlined,
                        size: 27,
                      ),
                    ),
                    8.pw,
                    GestureDetector(
                      onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              PickImagesOption(chatController: chatController),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image_outlined,
                          size: 27,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
