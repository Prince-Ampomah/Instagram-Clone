import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/model/reel_model/reel_comment.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/utils.dart';
import '../../model/post_model/comment_model.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';

class CommentController extends GetxController {
  static CommentController instance = Get.find<CommentController>();

  static TextEditingController commentTextFieldController =
      TextEditingController();
  static FocusNode commentTextFiedFocus = FocusNode();

  // initialize firestore db contract
  FirestoreDB firestoreDB = FirestoreDBImpl();

  // query user data from local disk

  StreamSubscription? _streamSubscription;
  bool hasError = false, hasData = true, waiting = true, done = false;

  //Initialize Setters;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _setCommentList = [];
  String _setTextState = '';

  //Initialize getters
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get getCommentList =>
      _setCommentList;
  String get getTextState => _setTextState;

  @override
  void dispose() {
    commentTextFieldController.dispose();
    commentTextFiedFocus.dispose();
    cancelSubscription();
    super.dispose();
  }

  fetchComments() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection(Const.postCommentCollection)
        .orderBy('time', descending: true)
        .snapshots()
        .listen((data) {
      _setCommentList = data.docs.toList();
      if (_setCommentList!.isEmpty) {
        hasData = false;
        _setTextState = 'No Comment on this post';
        update();
      }
      waiting = false;
      update();
    }, onError: (Object error, StackTrace stackTrace) {
      hasError = true;
      _setTextState = 'Something went wrong: $error';
      update();
    }, onDone: () {
      done = true;
      update();
    });
  }

  Future<void> sendPostComment() async {
    try {
      // get the post id from local db
      String postId = HiveServices.getPostId();

      if (commentTextFieldController.text.trim().isNotEmpty) {
        UserModel? userModel = HiveServices.getUserBox().get(Const.currentUser);

        CommentModel commentModel = CommentModel(
          id: FirestoreDBImpl.generateFirestoreId(Const.postCommentCollection),
          postId: postId,
          message: commentTextFieldController.text,
          userHandle: userModel!.userHandle,
          userProfileImage: userModel.profileImage,
          time: DateTime.now(),
        );

        commentTextFieldController.clear();

        await firestoreDB.addDocWithId(
          Const.postCommentCollection,
          commentModel.id!,
          {
            ...commentModel.toJson(),
            'time': FieldValue.serverTimestamp(),
          },
        );

        updateCommentValue(Const.postsCollection, postId);
      } else {
        showToast(msg: 'Add a comment');
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  Future<void> sendReelComment(String reelId) async {
    try {
      if (commentTextFieldController.text.trim().isNotEmpty) {
        UserModel? userModel = HiveServices.getUserBox().get(Const.currentUser);

        ReelCommentModel reelCommentModel = ReelCommentModel(
          id: FirestoreDBImpl.generateFirestoreId(Const.reelCommentCollection),
          reelId: reelId,
          message: commentTextFieldController.text,
          userHandle: userModel!.userHandle,
          userProfileImage: userModel.profileImage,
          time: DateTime.now(),
        );

        commentTextFieldController.clear();

        await firestoreDB.addDocWithId(
          Const.reelCommentCollection,
          reelCommentModel.id!,
          {
            ...reelCommentModel.toJson(),
            'time': FieldValue.serverTimestamp(),
          },
        );

        updateCommentValue(Const.reelCollection, reelId);
      } else {
        showToast(msg: 'Add a comment');
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  updateCommentValue(String collection, String docId) async {
    return await firestoreDB.updateDoc(
      collection,
      docId,
      {
        'comment': FieldValue.increment(1),
      },
    );
  }

  cancelSubscription() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
    }
  }
}
