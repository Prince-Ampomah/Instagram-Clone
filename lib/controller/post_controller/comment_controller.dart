import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/model/post_model/comment_model.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/utils.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';

class CommentController extends GetxController {
  static CommentController instance = Get.find<CommentController>();

  static TextEditingController commentTextFieldController =
      TextEditingController();

  // initialize firestore db contract
  FirestoreDB firestoreDB = FirestoreDBImpl();

  // query user data from local disk
  UserModel? userModel = HiveServices.getUserBox().get(Const.currentUser);

  StreamSubscription? _streamSubscription;
  bool hasError = false, hasData = true, waiting = true, done = false;

  //Initialize Setters;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _setCommentList = [];
  String _setTextState = '';

  //Initialize getters
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get getCommentList =>
      _setCommentList;
  String get getTextState => _setTextState;

  CommentController() {
    fetchComments();
  }

  @override
  void dispose() {
    commentTextFieldController.dispose();
    cancelSubscription();
    super.dispose();
  }

  fetchComments() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection(Const.commentsCollection)
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

  Future<void> sendComment() async {
    String postId = HiveServices.getPostId();
    if (commentTextFieldController.text.isNotEmpty) {
      CommentModel commentModel = CommentModel(
        id: FirestoreDBImpl.generateFirestoreId(Const.commentsCollection),
        postId: postId,
        message: commentTextFieldController.text,
        userHandle: userModel!.userHandle,
        userProfileImage: userModel?.profileImage,
        time: DateTime.now(),
      );

      try {
        await firestoreDB.addDocWithId(
          Const.commentsCollection,
          commentModel.id!,
          {
            ...commentModel.toJson(),
            'time': FieldValue.serverTimestamp(),
          },
        );
        commentTextFieldController.clear();
        await firestoreDB.updateDoc(Const.postsCollection, postId, {
          'comment': FieldValue.increment(1),
        });
      } catch (e) {
        Utils.showErrorMessage(e.toString());
      }
    } else {
      showToast(msg: 'Add a comment');
    }
  }

  cancelSubscription() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
    }
  }
}
