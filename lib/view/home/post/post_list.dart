import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/constants/constants.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/widgets/cus_circular_progressbar.dart';
import '../../../model/post_model/post_model.dart';
import 'post_list_item.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    Box<PostModel> postBox = HiveServices.getPosts();

    // use stream builder for the mean time
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection(Const.postsCollection)
          .orderBy('timePosted', descending: true)
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomCircularProgressBar());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No feed posted yet'));
        }

        if (snapshot.hasData) {
          saveDataOffline(snapshot, postBox);
          return PostListItem(snapshot: snapshot);
        }

        return Center(child: Text('Something went wrong: ${snapshot.error}'));
      },
    );

    // might reuse this
/**
 *     return GetBuilder<PostController>(
      builder: (controller) {
        if (controller.waiting) {
          return const Center(
            child: CustomCircularProgressBar(),
          );
        }

        if (controller.hasError) {
          return Center(
            child: Text(controller.getTextState),
          );
        }

        if (controller.hasData) {
          return PostListItem(postController: controller);
        }

        return Center(child: Text(controller.getTextState));
      },
    );
 */
  }

  saveDataOffline(snapshot, Box<PostModel> postBox) async {
    Map<String, PostModel> postChanges = {};
    List<String> postsRemoved = [];

    for (var docRef in snapshot.data!.docChanges) {
      if (docRef.type == DocumentChangeType.removed) {
        postsRemoved.add(docRef.doc.id);
      } else {
        postChanges[docRef.doc.id] = PostModel.fromJson({
          ...docRef.doc.data()!,
        });
      }
    }
    // save post offline
    await postBox.putAll(postChanges);

    // delete all post data from offline db
    //that has been deleted online
    await postBox.deleteAll(postsRemoved);
  }
}
