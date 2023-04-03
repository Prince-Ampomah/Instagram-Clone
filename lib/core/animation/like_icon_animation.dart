import 'dart:async';

import 'package:flutter/material.dart';

class AnimateLikeIcon extends StatefulWidget {
  const AnimateLikeIcon({super.key});

  @override
  State<AnimateLikeIcon> createState() => _AnimateLikeIconState();
}

class _AnimateLikeIconState extends State<AnimateLikeIcon>
    with TickerProviderStateMixin {
  late Animation _heartAnimation;
  late AnimationController _heartAnimationController;

  Timer? timer;

  bool showLikeIcon = false;

  void likeIconVisibiltyTimer() {
    setState(() {
      showLikeIcon = true;
      _heartAnimationController.forward();
    });

    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        showLikeIcon = false;
        _heartAnimationController.stop();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _heartAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
      reverseDuration: const Duration(milliseconds: 400),
    );
    _heartAnimation = Tween(begin: 120.0, end: 170.0).animate(
      CurvedAnimation(
        curve: Curves.elasticOut,
        reverseCurve: Curves.ease,
        parent: _heartAnimationController,
      ),
    );

    _heartAnimationController.addStatusListener(
      (AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _heartAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _heartAnimationController.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    _heartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _heartAnimationController,
      builder: (context, child) {
        return Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.favorite,
            size: _heartAnimation.value,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
