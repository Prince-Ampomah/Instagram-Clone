import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';
import 'package:instagram_clone/view/messages/message_list_item_view.dart';

import '../../core/constants/constants.dart';
import '../../core/widgets/cus_circular_progressbar.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = HiveServices.getUserBox().get(Const.currentUser);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(Const.usersCollection)
          .where('listOfFollowers', arrayContains: userModel!.userId!)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomCircularProgressBar());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('You have not followed any one yet'));
        }

        if (snapshot.hasData) {
          return MessageListItem(snapshot: snapshot);
        }

        return Center(child: Text('Something went wrong: ${snapshot.error}'));
      },
    );
  }
}
