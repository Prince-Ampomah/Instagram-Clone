import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/view/messages/chat_room/chat_messages_list_item.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/cus_circular_progressbar.dart';

class ChatMessagesList extends StatefulWidget {
  const ChatMessagesList({super.key});

  @override
  State<ChatMessagesList> createState() => _ChatMessagesListState();
}

class _ChatMessagesListState extends State<ChatMessagesList> {
  late String? chatId;

  @override
  void initState() {
    super.initState();

    chatId = HiveServices.getChatId();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection(Const.chatCollection)
          .doc(chatId)
          .collection(Const.messagesCollection)
          .orderBy(Const.timeSent, descending: true)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot snapshot,
      ) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomCircularProgressBar());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const SizedBox();
        }

        if (snapshot.hasData) {
          return ChatMessagesListItem(snapshot: snapshot);
        }

        return Center(child: Text('Something went wrong: ${snapshot.error}'));
      },
    );
  }
}
