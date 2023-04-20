import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/core/widgets/cus_circular_image.dart';
import 'package:instagram_clone/view/messages/chat_room/chat_preview_image.dart';

import '../../../controller/chat_controller/chat_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_cached_image.dart';

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
                        await chatController.pickImagesFromGallery();
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

      // Column(
      //   children: [
      //     GetBuilder<ChatController>(
      //       builder: (controller) {
      //         if (ChatController.instance.chatMedia!.isNotEmpty) {
      //           return const MessageImagePreview();
      //         } else {
      //           return const SizedBox();
      //         }
      //       },
      //     ),

      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Container(
      //           height: 40,
      //           width: 40,
      //           decoration: BoxDecoration(
      //             color: AppColors.buttonColor,
      //             borderRadius: BorderRadius.circular(100),
      //           ),
      //           child: const Icon(
      //             Icons.camera_alt_outlined,
      //             color: Colors.white,
      //           ),
      //         ),
      //         Flexible(
      //           child: TextField(
      //             focusNode: ChatController.chatTextFieldFocus,
      //             controller: ChatController.chatTextController,
      //             maxLines: 7,
      //             minLines: 1,
      //             textCapitalization: TextCapitalization.sentences,
      //             textInputAction: TextInputAction.newline,
      //             textAlign: TextAlign.justify,
      //             cursorColor: AppColors.blackColor,
      //             decoration: const InputDecoration(
      //               contentPadding: EdgeInsets.all(8),
      //               border: InputBorder.none,
      //               hintText: 'Message...',
      //             ),
      //           ),
      //         ),
      //         GetBuilder<ChatController>(
      //           builder: (chatController) {
      //             if (chatController.isTyping &&
      //                 ChatController.chatTextController.text
      //                     .trim()
      //                     .isNotEmpty) {
      //               return GestureDetector(
      //                 onTap: () {
      //                   chatController.sendTextMessage();
      //                 },
      //                 child: const Padding(
      //                   padding: EdgeInsets.fromLTRB(5, 8, 15, 8),
      //                   child: Text(
      //                     'Send',
      //                     style: TextStyle(
      //                       color: AppColors.chatColor,
      //                       fontSize: 18,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             } else {
      //               return Row(
      //                 children: [
      //                   GestureDetector(
      //                     onTap: () {
      //                       showToast(msg: 'record');
      //                     },
      //                     child: const Icon(
      //                       Icons.mic_none_outlined,
      //                       size: 27,
      //                     ),
      //                   ),
      //                   8.pw,
      //                   GestureDetector(
      //                     onTap: () async {
      //                       await chatController.pickImagesFromGallery();
      //                     },
      //                     child: const Padding(
      //                       padding: EdgeInsets.all(8.0),
      //                       child: Icon(
      //                         Icons.image_outlined,
      //                         size: 27,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               );
      //             }
      //           },
      //         ),
      //       ],
      //     ),

      //   ],
      // ),
    );
  }
}

class MessageImagePreview extends StatelessWidget {
  const MessageImagePreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.fromLTRB(5, 10, 10, 0),
          // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: GestureDetector(
            onTap: () {
              sendToPage(
                context,
                const ChatImagePreview(),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: CustomCachedImage(
                imageUrl: ChatController.instance.chatMedia![0]!,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(width: 0.5, color: Colors.black),
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
