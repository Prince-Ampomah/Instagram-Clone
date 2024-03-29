import 'package:flutter/material.dart';

import 'post/post_list.dart';
import 'story/story.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController scrollController = ScrollController();
  Future<void> _refreshPosts() async {
    // Fetch new posts from the API
    await Future.delayed(const Duration(seconds: 10));
  }

  void loadMorePost() {
    return scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // load more data here
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadMorePost();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      children: const [
        Story(),
        Divider(),
        PostList(),
      ],
    );

    // return RefreshIndicator(
    //   onRefresh: _refreshPosts,
    //   color: Colors.white,
    //   backgroundColor: const Color(0xFF5B5B5B),
    //   strokeWidth: 2,
    //   child: ListView(
    //     controller: scrollController,
    //     children: const [
    //       Story(),
    //       Divider(),
    //       PostList(),
    //     ],
    //   ),
    // );
  }
}
