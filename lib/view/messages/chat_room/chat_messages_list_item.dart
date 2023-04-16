import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:instagram_clone/model/chat_model/chat_model.dart';
import 'package:instagram_clone/view/messages/chat_room/chat_text_bubble.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/date_time_convertor.dart';
import 'chat_date_time_header.dart';

class ChatMessagesListItem extends StatelessWidget {
  const ChatMessagesListItem({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: true,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (BuildContext context, int index) {
        ChatModel chatModel =
            ChatModel.fromJson(snapshot.data.docs[index].data());

        return ChatBubbleTextMessage(chatModel: chatModel);
      },
    );

    // return GroupedListView<QueryDocumentSnapshot<Map<String, dynamic>>,
    //     dynamic>(
    //   physics: const NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   sort: true,
    //   reverse: true,
    //   order: GroupedListOrder.DESC,
    //   elements: snapshot.data!.docs,
    //   groupBy: (snapshot) => DateTime(
    //     snapshot.data()[Const.timeSent]?.toDate().year ?? DateTime.now().year,
    //     snapshot.data()[Const.timeSent]?.toDate().month ?? DateTime.now().month,
    //     snapshot.data()[Const.timeSent]?.toDate().day ?? DateTime.now().day,
    //   ),
    //   // itemComparator: (item1, item2) {
    //   //   return item2
    //   //       .data()[Const.timeSent]
    //   //       .toDate()
    //   //       .compareTo(item1.data()[Const.timeSent].toDate());
    //   // },
    //   groupHeaderBuilder: (snapshot) =>
    //       ChatDateAndTimeHeader(snapshot: snapshot),
    //   indexedItemBuilder: (context, element, index) {
    //     ChatModel chatModel =
    //         ChatModel.fromJson(snapshot.data.docs[index].data());

    //     return ChatBubbleTextMessage(chatModel: chatModel);
    //   },
    // );
  }
}
