import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/story_controller/query_story_controller.dart';
import '../../../../model/story_model/story_model.dart';
import 'others_story_list_item.dart';

class OthersStoryList extends StatelessWidget {
  const OthersStoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QueryStoryController(),
      builder: (context, child) {
        final controller = Provider.of<QueryStoryController>(context);

        if (controller.waiting) {
          // return const Center(child: CustomCircularProgressBar());
          return const SizedBox();
        }

        if (controller.hasError) {
          return Center(child: Text(controller.getTextState));
        }

        if (controller.hasData) {
          return Row(
            children: [
              ...List.generate(
                controller.getStoryList!.length,
                (index) {
                  StoryModel storyModel = StoryModel.fromJson(
                    controller.getStoryList![index].data(),
                  );
                  return UsersStory(storyModel: storyModel);
                },
              ),
            ],
          );
        } else {
          // return Center(child: Text(controller.getTextState));
          return const SizedBox();
        }
      },
    );
  }
}
