// import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/cus_rich_text.dart';

class PostReactions extends StatelessWidget {
  const PostReactions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: [
                  // const Icon(
                  //   Icons.favorite_outline,
                  //   size: 30,
                  // ),
                  SizedBox(
                    height: 27,
                    child: Image.asset(
                      Const.instragramfavoriteIcon,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    height: 22,
                    child: Image.asset(
                      Const.instragramCommentIcon,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    height: 22,
                    child: Image.asset(
                      Const.instragramSendIcon,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.bookmark_border,
                size: 30,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [Text('Liked by Elvis and 10,971')],
          ),
          const SizedBox(height: 8),
          const CustomRichText(
            text1: 'citi973fm ',
            text2: 'Let us build an instagram together Fellas!',
            text1Style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'View all 172 comments',
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
