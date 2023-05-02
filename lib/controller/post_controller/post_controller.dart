import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/repository/repository_abstract/database_abstract.dart';
import 'package:instagram_clone/repository/respository_implementation/database_implementation.dart';

import '../../core/utils/utils.dart';

class PostController extends GetxController {
  static PostController instance = Get.find<PostController>();

  FirestoreDB firestoreDB = FirestoreDBImpl();

  StreamSubscription? _streamSubscription;
  bool hasError = false, hasData = true, waiting = true, done = false;

  //Initialize Setters;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _setPostList = [];
  String _setTextState = '';

  //Initialize getters
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get getPostList =>
      _setPostList;
  String get getTextState => _setTextState;

  PostController() {
    getPosts();
  }

  getPosts() async {
    var postBox = HiveServices.getPosts();

    return _streamSubscription = FirebaseFirestore.instance
        .collection(Const.postsCollection)
        .orderBy('timePosted', descending: true)
        .snapshots()
        .listen((data) async {
      _setPostList = data.docs.toList();

      Map<String, PostModel> postChanges = {};
      List<String> postsRemoved = [];

      for (var docRef in data.docChanges) {
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

      if (_setPostList!.isEmpty) {
        hasData = false;
        _setTextState = 'No feed posted yet';
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

  cancelSubscription() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await firestoreDB.deleteDoc(Const.postsCollection, postId);
      deletePostComment(postId);
      Get.back();
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  deletePostComment(String postId) {
    firestoreDB
        .getDocByField(Const.commentsCollection, 'postId', postId)
        .then((value) {
      for (var doc in value.docs) {
        firestoreDB.deleteDoc(Const.commentsCollection, doc.id);
      }
    });
  }

  @override
  void dispose() {
    cancelSubscription();
    super.dispose();
  }
}
