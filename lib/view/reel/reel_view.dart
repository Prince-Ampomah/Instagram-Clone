import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class ReelView extends StatelessWidget {
  const ReelView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Image.asset(
            Const.princeImage,
          );
        });
  }
}
