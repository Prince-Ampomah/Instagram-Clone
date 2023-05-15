import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/repository/repository_abstract/database_abstract.dart';
import 'package:instagram_clone/repository/respository_implementation/database_implementation.dart';

import '../../core/utils/utils.dart';
import '../../repository/respository_implementation/auth_implementation.dart';

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

      await updateNumOfPostLocally();

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

  Future<void> updateNumOfPostLocally() async {
    try {
      var countPost = await updateAndGetUserPost();

      var userModel = HiveServices.getUserBox().get(Const.currentUser);

      userModel?.numberOfPost = countPost;

      userModel?.save();
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  Future<int> updateAndGetUserPost() async {
    try {
      var posts = await firestoreDB.getDocByField(
        Const.postsCollection,
        'userId',
        firebaseAuth.currentUser!.uid,
      );

      await firestoreDB.updateDoc(
        Const.usersCollection,
        firebaseAuth.currentUser!.uid,
        {
          'numberOfPost': posts.docs.length,
        },
      );

      return posts.docs.length;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    cancelSubscription();
    super.dispose();
  }
}
