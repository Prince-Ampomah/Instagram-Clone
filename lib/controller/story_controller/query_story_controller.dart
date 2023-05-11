import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/utils.dart';
import 'package:instagram_clone/repository/repository_abstract/database_abstract.dart';
import 'package:instagram_clone/repository/respository_implementation/database_implementation.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../model/story_model/story_model.dart';

class QueryStoryController extends ChangeNotifier {
  StreamSubscription? _streamSubscription;
  bool hasError = false, hasData = true, waiting = true, done = false;

  //Initialize Setters;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _setStoryList = [];
  String _setTextState = '';

  //Initialize getters
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get getStoryList =>
      _setStoryList;
  String get getTextState => _setTextState;

  QueryStoryController() {
    queryStories();
  }

  @override
  void dispose() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
    }

    super.dispose();
  }

  queryStories() async {
    return _streamSubscription = FirebaseFirestore.instance
        .collection(Const.storyCollection)
        .where(
          'userId',
          isNotEqualTo:
              HiveServices.getUserBox().get(Const.currentUser)!.userId,
        )
        .snapshots()
        .listen((data) async {
      _setStoryList = data.docs.toList();

      notifyListeners();

      if (_setStoryList!.isEmpty) {
        hasData = false;
        _setTextState = 'No Story yet';

        notifyListeners();
      }
      waiting = false;

      notifyListeners();
    }, onError: (Object error, StackTrace stackTrace) {
      hasError = true;
      _setTextState = 'Something went wrong: $error';

      notifyListeners();
    }, onDone: () {
      done = true;

      notifyListeners();
    });
  }

  static queryCurrentUserStory() async {
    FirestoreDB firestoreDB = FirestoreDBImpl();
    // StoryModel storyModel = StoryModel();

    return await firestoreDB.getDocById(
      Const.storyCollection,
      HiveServices.getUserBox().get(Const.currentUser)!.userId!,
    );

    // dynamic result;

    // try {
    //   // var documentSnapshot = await firestoreDB.getDocById(
    //   //   Const.storyCollection,
    //   //   HiveServices.getUserBox().get(Const.currentUser)!.userId!,
    //   // );

    //   return result;

    //   // return storyModel =
    //   //     StoryModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    // } catch (e) {
    //   Utils.showErrorMessage(e.toString());
    // }

    // // return storyModel;

    // return result;
  }
}
