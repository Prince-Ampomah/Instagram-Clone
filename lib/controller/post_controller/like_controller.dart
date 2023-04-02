import 'dart:async';

import 'package:get/get.dart';

class LikeController extends GetxController {
  static LikeController instance = Get.find<LikeController>();

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

  @override
  void dispose() {
    _likeIconTimer?.cancel();
    super.dispose();
  }
}
