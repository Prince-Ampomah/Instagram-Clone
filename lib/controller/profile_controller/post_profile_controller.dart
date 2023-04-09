import 'package:get/get.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';

class PostProfileController extends GetxController {
  StreamSubscription? _streamSubscription;
  bool hasError = false, hasData = true, waiting = true, done = false;

  //Initialize Setters;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _setPostProfileList = [];
  String _setTextState = '';

  //Initialize getters
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get getPostProfileList =>
      _setPostProfileList;
  String get getTextState => _setTextState;

  PostProfileController() {
    queryPostByUser();
  }

  queryPostByUser() async {
    // var postBox = HiveServices.getPosts();

//  TODO: fix user id bug here
    var user = HiveServices.getUserBox().get(Const.currentUser);

    return _streamSubscription = FirebaseFirestore.instance
        .collection(Const.postsCollection)
        .where('userId', isEqualTo: user!.userId!)
        .orderBy('timePosted', descending: true)
        .snapshots()
        .listen((data) async {
      _setPostProfileList = data.docs.toList();

      update();

      // Map<String, PostModel> postChanges = {};
      // List<String> postsRemoved = [];

      // for (var docRef in data.docChanges) {
      //   if (docRef.type == DocumentChangeType.removed) {
      //     postsRemoved.add(docRef.doc.id);
      //   } else {
      //     postChanges[docRef.doc.id] = PostModel.fromJson({
      //       ...docRef.doc.data()!,
      //     });
      //   }
      // }
      // // save post offline
      // await postBox.putAll(postChanges);

      // delete all post data from offline db
      //that has been deleted online
      // await postBox.deleteAll(postsRemoved);

      if (_setPostProfileList!.isEmpty) {
        hasData = false;
        _setTextState = 'No feed yet';
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
