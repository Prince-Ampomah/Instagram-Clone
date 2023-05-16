import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class StoryHighlight extends StatelessWidget {
  const StoryHighlight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            3,
            (index) {
              return Container(
                height: 60,
                width: 60,
                margin: const EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, border: Border.all()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(Const.userImage),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
