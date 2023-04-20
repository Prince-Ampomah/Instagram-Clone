import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/model/chat_model/chat_model.dart';
import 'package:instagram_clone/view/messages/chat_room/chat_image_bubble_details.dart';

class ChatBubbleImageMessage extends StatelessWidget {
  const ChatBubbleImageMessage({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    bool isMe = chatModel.senderId == FirebaseAuth.instance.currentUser!.uid;
    return GestureDetector(
      onTap: () {
        sendToPage(
          context,
          ChatImageDetails(
            chatMedia: chatModel.media,
          ),
        );
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.only(
          right: isMe ? 10.0 : 190.0,
          left: isMe ? 190.0 : 10.0,
          bottom: 10.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CustomCachedImage(
            imageUrl: chatModel.media!.first!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
