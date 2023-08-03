import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/view/home/story/current_user_story/active_story.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/services/hive_services.dart';
import '../../../../model/story_model/story_model.dart';
import 'non_updated_story.dart';

class CurrentUserStory extends StatelessWidget {
  const CurrentUserStory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection(Const.storyCollection)
          .doc(HiveServices.getUserBox().get(Const.currentUser)!.userId!)
          .get(),
      builder: (
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasData && snapshot.data!.exists) {
          var storyModel = StoryModel.fromJson(
            snapshot.data!.data() as Map<String, dynamic>,
          );

          return ActiveCurrentStory(storyModel: storyModel);
        } else {
          return const NonUpdatedStory();
        }
      },
    );
  }
}
