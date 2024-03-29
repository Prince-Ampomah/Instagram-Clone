import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/services/hive_services.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../core/widgets/cus_cached_image.dart';
import '../core/new_story_camera_view.dart';

class NonUpdatedStory extends StatelessWidget {
  const NonUpdatedStory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);

    var currentUser = HiveServices.getUserBox().get(Const.currentUser)!;

//  top: size.height * 0.06,
//                 left: size.width * 0.17,
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            sendToPage(context, const NewStoryPostCameraView());
          },
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                height: 75,
                width: 75,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 0.1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: CustomCachedImage(
                    imageUrl: currentUser.profileImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 22,
                  width: 22,
                  margin: const EdgeInsets.only(right: 7),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Text(
            'Your story',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
