import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/core/widgets/cus_circular_image.dart';
import 'package:instagram_clone/core/widgets/cus_read_more_text.dart';

import '../../../core/theme/app_colors.dart';
import '../../../model/chat_model/chat_model.dart';

class ChatBubbleTextMessage extends StatelessWidget {
  const ChatBubbleTextMessage({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    bool isMe = chatModel.senderId == FirebaseAuth.instance.currentUser!.uid;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        !isMe ? const CircularImageContainer() : const SizedBox(),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              right: isMe ? 10.0 : 80.0,
              left: isMe ? 80.0 : 10.0,
              bottom: 10.0,
            ),
            padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
            decoration: BoxDecoration(
              color: isMe ? AppColors.chatColor : AppColors.buttonBgColor,
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
            ),
            child: CustomReadMore(
              text: chatModel.message!,
              textStyle: TextStyle(
                color: isMe ? AppColors.whiteColor : AppColors.blackColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
