import 'package:flutter/material.dart';
import 'package:instagram_clone/controller/profile_controller/post_profile_controller.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/view/profile/current_user_profile/profile_posts_view.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_circular_progressbar.dart';
import '../../../core/widgets/cus_tab_bar.dart';
import '../../../core/widgets/cus_video_player.dart';

class ProfileViewGallery extends StatefulWidget {
  const ProfileViewGallery({
    super.key,
  });

  @override
  State<ProfileViewGallery> createState() => _ProfileViewGalleryState();
}

class _ProfileViewGalleryState extends State<ProfileViewGallery>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTabBar(
          tabController: tabController,
          indicatorWeight: .6,
          labelColor: AppColors.blackColor,
          indicatorColor: AppColors.blackColor,
          unselectedLabelColor: const Color(0xFFA7A7A7),
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.grid_on),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.contacts_outlined),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: tabController,
            children: [
              ChangeNotifierProvider(
                create: (context) => PostProfileController(),
                builder: (context, child) {
                  final controller = context.watch<PostProfileController>();
                  if (controller.waiting) {
                    return const Center(
                      child: CustomCircularProgressBar(),
                    );
                  }

                  if (controller.hasError) {
                    return Center(
                      child: Text(controller.getTextState),
                    );
                  }

                  if (controller.hasData) {
                    return ListPostProfileItem(controller: controller);
                  }

                  return Center(child: Text(controller.getTextState));
                },
              ),
              const Center(child: Text('tagged images')),
            ],
          ),
        ),
      ],
    );
  }
}

class ListPostProfileItem extends StatelessWidget {
  const ListPostProfileItem({
    super.key,
    required this.controller,
  });

  final PostProfileController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: List.generate(
        controller.getPostProfileList!.length,
        (index) {
          PostModel postModel =
              PostModel.fromJson(controller.getPostProfileList![index].data());

          return GestureDetector(
            onTap: () {
              sendToPage(
                context,
                UserProfilePostView(
                  userModel: HiveServices.getUserBox().get(Const.currentUser)!,
                  profileController: controller,
                ),
              );
            },
            child: Stack(
              children: [
                postModel.postType == Const.videoPostType
                    ? SizedBox(
                        width: size.width,
                        child: CusVideoPlayer(
                          videoPath: postModel.media.first!,
                          showControllBar: false,
                          showSettingsButton: false,
                        ),
                      )
                    : CustomCachedImage(
                        width: size.width,
                        imageUrl: postModel.media[0]!,
                        fit: BoxFit.cover,
                      ),
                if (postModel.media.length != 1)
                  const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.bookmarks,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
