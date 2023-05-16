import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';

class UserFollowerAndFollowingController extends ChangeNotifier {
  StreamSubscription? _streamSubscription;
  bool hasError = false, hasData = true, waiting = true, done = false;

  //Initialize Setters;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _setPostProfileList = [];
  String _setTextState = '';

  //Initialize getters
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get getPostProfileList =>
      _setPostProfileList;
  String get getTextState => _setTextState;

  UserFollowerAndFollowingController() {
    queryPostByUser();
  }

  queryPostByUser() async {
    var user = HiveServices.getUserBox().get(Const.currentUser);

    return _streamSubscription = FirebaseFirestore.instance
        .collection(Const.usersCollection)
        .where('userId', whereIn: user!.listOfFollowers)
        .orderBy('timePosted', descending: true)
        .snapshots()
        .listen((data) async {
      _setPostProfileList = data.docs.toList();

      // update();
      notifyListeners();

      if (_setPostProfileList!.isEmpty) {
        hasData = false;
        _setTextState = 'No feed yet';
        // update();
        notifyListeners();
      }
      waiting = false;
      // update();
      notifyListeners();
    }, onError: (Object error, StackTrace stackTrace) {
      hasError = true;
      _setTextState = 'Something went wrong: $error';
      // update();
      notifyListeners();
    }, onDone: () {
      done = true;
      // update();
      notifyListeners();
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
