import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/model/reel_model/reel_model.dart';
import 'package:instagram_clone/view/reel/reel_list_item.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/cus_circular_progressbar.dart';
import '../../core/services/hive_services.dart';

class ReelView extends StatefulWidget {
  const ReelView({super.key});

  @override
  State<ReelView> createState() => _ReelViewState();
}

class _ReelViewState extends State<ReelView> {
  late Box<ReelModel> reelBox;

  @override
  void initState() {
    super.initState();
    reelBox = HiveServices.getReels();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection(Const.reelCollection)
          .orderBy('timePosted', descending: true)
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomCircularProgressBar());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Reel posted yet'));
        }

        if (snapshot.hasData) {
          saveDataOffline(snapshot, reelBox);
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

  saveDataOffline(snapshot, Box<ReelModel> reelBox) async {
    Map<String, ReelModel> reelChanges = {};
    List<String> reelsRemoved = [];

    for (var docRef in snapshot.data!.docChanges) {
      if (docRef.type == DocumentChangeType.removed) {
        reelsRemoved.add(docRef.doc.id);
      } else {
        reelChanges[docRef.doc.id] = ReelModel.fromJson({
          ...docRef.doc.data()!,
        });
      }
    }

    await reelBox.putAll(reelChanges);

    await reelBox.deleteAll(reelsRemoved);
  }
}
