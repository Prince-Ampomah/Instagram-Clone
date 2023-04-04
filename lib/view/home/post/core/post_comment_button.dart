import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class CommentButton extends StatelessWidget {
  const CommentButton({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 22,
        child: Image.asset(
          Const.instragramCommentIcon,
          color: Colors.black,
        ),
      ),
    );
  }
}
