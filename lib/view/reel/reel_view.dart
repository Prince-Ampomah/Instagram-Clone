import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/view/reel/reel_list_item.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/cus_circular_progressbar.dart';
import '../../../model/post_model/post_model.dart';

class ReelView extends StatelessWidget {
  const ReelView({super.key});

  @override
  Widget build(BuildContext context) {
    // Box<PostModel> postBox = HiveServices.getPosts();

    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection(Const.reelCollection)
          .orderBy('timePosted', descending: true)
          .get(),
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
          return const Center(child: Text('No Reel posted yet'));
        }

        if (snapshot.hasData) {
          return ReelListItem(snapshot: snapshot);
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'Something went wrong: ${snapshot.error}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }

        return Center(child: Text('Something went wrong: ${snapshot.error}'));
      },
    );
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
