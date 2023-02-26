// import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:instagram_clone/model/feed_model/like_model.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/cus_rich_text.dart';

class FeedReaction extends StatelessWidget {
  const FeedReaction({
    super.key,
    required this.likeModel,
    this.caption,
    this.userHandle,
  });

  final LikeModel likeModel;
  final String? caption, userHandle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
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
            children: [
              Text('Liked by Elvis and ${likeModel.likes}'),
            ],
          ),
          const SizedBox(height: 8),
          CustomRichText(
            text1: '$userHandle ',
            text2: caption ?? '',
            text1Style: const TextStyle(
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
