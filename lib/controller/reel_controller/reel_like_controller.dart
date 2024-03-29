import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/utils/utils.dart';
import 'package:instagram_clone/model/reel_model/reel_model.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';

class ReelLikeController extends GetxController {
  static ReelLikeController instance = Get.find<ReelLikeController>();

  FirestoreDB firestoreDB = FirestoreDBImpl();

  bool _isLiked = false;
  int _likeCount = 0;

  bool _showLikeIcon = false;
  Timer? _likeIconTimer;

  bool get isLiked => _isLiked;
  int get likeCount => _likeCount;

  bool get showLikeIcon => _showLikeIcon;
  Timer? get likeIconTimer => _likeIconTimer;

  toggleLikeState() {
    _isLiked = !_isLiked;

    _likeCount += _isLiked ? 1 : -1;

    update();
  }

  likeOnlyOnDoubleTap() {
    _isLiked = true;
    _likeCount += 1;
    _showLikeIcon = true;
    _likeIconTimer?.cancel();
    _likeIconTimer = Timer(const Duration(milliseconds: 500), () {
      _showLikeIcon = false;
      update();
    });
    update();
  }

  toggleLike(String reelId) async {
    String? userId = HiveServices.getUserBox().get(Const.currentUser)!.userId;

    ReelModel? reelModel = HiveServices.getReels().get(reelId);

    if (!reelModel!.isLikedBy!.contains(userId)) {
      // add user to the liked list and increase the like
      return await firestoreDB.updateDoc(
        Const.reelCollection,
        reelId,
        {
          'isLikedBy': FieldValue.arrayUnion([userId]),
          // 'like': FieldValue.increment(1),
        },
      );
    } else {
      // remove user from the liked list and decrease the like
      return await firestoreDB.updateDoc(
        Const.reelCollection,
        reelId,
        {
          'isLikedBy': FieldValue.arrayRemove([userId]),
          // 'like': FieldValue.increment(-1),
        },
      );
    }
  }

  likePostOnly(String reelId) async {
    try {
      String? userId = HiveServices.getUserBox().get(Const.currentUser)!.userId;

      ReelModel? reelModel = HiveServices.getReels().get(reelId);

      if (!reelModel!.isLikedBy!.contains(userId)) {
        // add user to the liked list and increase the like
        await firestoreDB.updateDoc(
          Const.reelCollection,
          reelId,
          {
            'isLikedBy': FieldValue.arrayUnion([userId]),
          },
        );
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  void likeIconVisibiltyTimer() {
    _showLikeIcon = true;

    _likeIconTimer?.cancel();
    _likeIconTimer = Timer(const Duration(milliseconds: 1000), () {
      _showLikeIcon = false;
      update();
    });

    update();
  }

  @override
  void dispose() {
    _likeIconTimer?.cancel();
    super.dispose();
  }
}
