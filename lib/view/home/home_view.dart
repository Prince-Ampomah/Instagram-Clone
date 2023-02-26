import 'package:flutter/material.dart';

import 'feed/feed_list.dart';
import 'story/story.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Story(),
        Divider(),
        FeedList(),
      ],
    );
  }
}
