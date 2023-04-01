import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/constants/constants.dart';

class PostController extends GetxController {
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
    _streamSubscription = FirebaseFirestore.instance
        .collection(Const.postsCollection)
        .orderBy('timePosted', descending: true)
        .snapshots()
        .listen((data) {
      _setPostList = data.docs.toList();
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

  @override
  void dispose() {
    cancelSubscription();
    super.dispose();
  }
}
