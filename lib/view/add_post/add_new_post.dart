import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';

import '../../controller/post_controller/new_post_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/widgets/cus_appbar.dart';
import '../../core/widgets/cus_cached_image.dart';
import '../../core/widgets/cus_video_player.dart';
import 'preview_image.dart';

class AddNewPost extends StatelessWidget {
  const AddNewPost({super.key, this.isAVideoFile = false});

  final bool? isAVideoFile;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'New Post',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                await NewPostController.instance.addNewPost(
                  isAVideoFile! ? Const.videoPostType : Const.imagePostType,
                );
              },
              icon: const Icon(
                Icons.check,
                color: AppColors.buttonColor,
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              Row(
                children: [
                  if (isAVideoFile!)
                    SizedBox(
                      height: size.height * 0.12,
                      width: 150,
                      child: CusVideoPlayer(
                        videoPath: NewPostController.instance.media.first,
                        showControllBar: false,
                        showSettingsButton: false,
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () => sendToPage(context, const PreivewImage()),
                      child: Stack(
                        children: [
                          CustomCachedImage(
                            imageUrl: NewPostController.instance.media.first,
                            height: size.height * 0.12,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                          if (NewPostController.instance.media.length != 1)
                            const Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.bookmarks,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: NewPostController.captionController,
                        maxLines: 20,
                        minLines: 1,
                        textInputAction: TextInputAction.newline,
                        cursorColor: AppColors.blackColor,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write a caption...',
                        ),
                        onSaved: (value) {
                          NewPostController.captionController.text =
                              value!.trim();
                        },
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    SizedBox(height: 10),
                    Text('Tag People'),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    Text('Add location'),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    Text('Add music')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
