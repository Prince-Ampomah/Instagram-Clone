import 'package:flutter/material.dart';

import 'post/post.dart';
import 'stories/stories.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Stories(),
          Divider(),
          Post(),
          Post(),
          Post(),
        ],
      ),
    );
  }
}


  // gradient: LinearGradient(
  //                           begin: Alignment.centerLeft,
  //                           end: Alignment.centerRight,
  //                           colors: AppColors.storyBorderColors,
  //                         ),