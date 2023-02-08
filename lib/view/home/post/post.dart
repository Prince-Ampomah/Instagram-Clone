import 'package:flutter/material.dart';

import 'core/post_reaction.dart';
import 'core/posted_by.dart';
import 'image/image_post.dart';

class Post extends StatelessWidget {
  const Post({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PostedBy(),
        PostedItem(),
        PostReactions(),
      ],
    );
  }
}
