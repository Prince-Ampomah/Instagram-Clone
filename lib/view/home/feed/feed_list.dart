import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';
import 'package:instagram_clone/model/feed_model/feed_model.dart';
import 'package:instagram_clone/view/home/feed/feed_item.dart';

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: FeedModel.feed.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == FeedModel.feed.length) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: LoadingSpinner(),
          );
        } else {
          FeedModel feedModel = FeedModel.feed[index];
          return FeedItem(feedModel: feedModel);
        }
      },
    );
  }
}
