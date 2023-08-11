import 'package:flutter/material.dart';
// import "package:story_view/story_view.dart";
import "package:flutter_story_view/flutter_story_view.dart";
import 'package:flutter_story_view/models/story_item.dart';
import '../../../../core/constants/constants.dart';

class StoryMedia extends StatefulWidget {
  const StoryMedia({
    super.key,
    required this.media,
    required this.type,
  });

  final List media;
  final String type;

  @override
  State<StoryMedia> createState() => _StoryMediaState();
}

class _StoryMediaState extends State<StoryMedia> {
  late PageController? pageController;
  // late StoryController storyController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // storyController = StoryController();
  }

  @override
  void dispose() {
    // storyController.dispose();
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: FlutterStoryView(
        onComplete: () {
          Navigator.pop(context);
        },
        onPageChanged: (index) {
          print("currentPageIndex = $index");
        },
        storyItems: const [
          StoryItem(
            url:
                "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            type: StoryItemType.video,
            viewers: [],
            duration: 10,
          ),
        ],
        // storyItems: storyItems,
      ),

      // StoryView(
      //   storyItems: storyItems,
      //   controller: storyController,
      //   repeat: false,
      //   onStoryShow: (s) {},
      //   onComplete: () {
      //     Navigator.pop(context);
      //   },
      //   onVerticalSwipeComplete: (direction) {
      //     if (direction == Direction.down) {
      //       Navigator.pop(context);
      //     }
      //   },
      // ),
    );

/** 
 * return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: GestureDetector(
        onTapDown: (details) {},
        child: PageView.builder(
          controller: pageController,
          itemCount: widget.media.length,
          itemBuilder: (context, index) {
            return CustomCachedImage(
              imageUrl: widget.media[index],
              fit: BoxFit.contain,
              width: size.width,
              height: size.height,
              placeholderWidget: const CustomCircularProgressBar(),
            );
          },
        ),
      ),
    );
  
*/
  }

  List<StoryItem> get storyItems {
    return List.generate(widget.media.length, (index) {
      switch (widget.type) {
        case Const.imageStoryType:
          return StoryItem(
            url: widget.media[index],
            type: StoryItemType.image,
            viewers: [],
            duration: 3,
          );
        case Const.videoStoryType:
          return StoryItem(
            url: widget.media[index],
            type: StoryItemType.video,
            viewers: [],
            duration: 3,
          );

        default:
          return StoryItem(
            url: widget.media[index],
            type: StoryItemType.image,
            viewers: [],
            duration: 3,
          );
      }
    });
  }

  // List<StoryItem?> get storyItems {
  //   return List.generate(
  //     widget.media.length,
  //     (index) {
  //       switch (widget.type) {
  //         case Const.videoStoryType:
  //           return StoryItem.pageVideo(
  //             widget.media[index],
  //             controller: storyController,
  //           );

  //         case Const.imageStoryType:
  //           return StoryItem.pageImage(
  //             controller: storyController,
  //             url: widget.media[index],
  //           );
  //         default:
  //       }
  //     },
  //   ).toList();
  // }
}
