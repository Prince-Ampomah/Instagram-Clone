import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/view/messages/chat_room/chat_text_bubble.dart';

import '../../../core/constants/constants.dart';
import '../../../model/chat_model/chat_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.chatModel}) : super(key: key);

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    //assign [Current FirebaseUserId] to the variable [currentUserId]
    // String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // bool isMe = chatModel.senderId! == currentUserId;

    return Container(
      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 8.0),
      child: chatModel.messageType == Const.text
          ? ChatBubbleTextMessage(chatModel: chatModel)
          : Container(),
    );
  }
}
