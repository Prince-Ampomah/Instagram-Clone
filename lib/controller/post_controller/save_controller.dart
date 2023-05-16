import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/utils.dart';
import '../../model/post_model/post_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';

class SavePostController extends GetxController {
  static SavePostController instance = Get.find<SavePostController>();

  bool _isSaved = false;

  bool get isSaved => _isSaved;

  FirestoreDB firestoreDB = FirestoreDBImpl();

  toggleSaveState() {
    _isSaved = !_isSaved;
    update();
  }

  savePost(String postId) async {
    try {
      String? userId = HiveServices.getUserBox().get(Const.currentUser)!.userId;

      // query the post from offline db
      PostModel? postModel = HiveServices.getPosts().get(postId);

      if (!postModel!.isSavedBy!.contains(userId)) {
        // add user to the saved list and increase the like
        await firestoreDB.updateDoc(
          Const.postsCollection,
          postId,
          {
            'isSavedBy': FieldValue.arrayUnion([userId]),
          },
        );

        showToast(msg: 'Post Saved', bgColor: Colors.blue);
      } else {
        // remove user from the saved list and decrease the like
        await firestoreDB.updateDoc(
          Const.postsCollection,
          postId,
          {
            'isSavedBy': FieldValue.arrayRemove([userId]),
          },
        );

        showToast(msg: 'Post Removed', bgColor: Colors.blue);
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }
}
