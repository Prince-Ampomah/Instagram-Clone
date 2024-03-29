import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/view/profile/users_profile/users_profile_posts_view.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_circular_progressbar.dart';
import '../../../core/widgets/cus_tab_bar.dart';
import '../../../core/widgets/cus_video_player.dart';

class UsersProfileViewGallery extends StatefulWidget {
  const UsersProfileViewGallery({
    super.key,
    this.postModel,
  });

  final PostModel? postModel;

  @override
  State<UsersProfileViewGallery> createState() =>
      _UsersProfileViewGalleryState();
}

class _UsersProfileViewGalleryState extends State<UsersProfileViewGallery>
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
              UserProfileFeeds(postModel: widget.postModel),
              const Center(child: Text('tagged images')),
            ],
          ),
        ),
      ],
    );
  }
}

class UserProfileFeeds extends StatelessWidget {
  const UserProfileFeeds({
    super.key,
    this.postModel,
  });

  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection(Const.postsCollection)
          .where('userId', isEqualTo: postModel!.userId)
          .orderBy('timePosted', descending: true)
          .get(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomCircularProgressBar());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No feed posted yet'));
        }

        if (snapshot.hasData) {
          return ListPostProfileItem(snapshot: snapshot);
        }

        return Center(child: Text('Something went wrong: ${snapshot.error}'));
      },
    );
  }
}

class ListPostProfileItem extends StatelessWidget {
  const ListPostProfileItem({
    super.key,
    this.snapshot,
  });

  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? snapshot;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: List.generate(
        snapshot!.data!.docs.length,
        (index) {
          PostModel postModel = PostModel.fromJson(
            snapshot!.data!.docs[index].data(),
          );

          return GestureDetector(
            onTap: () {
              sendToPage(
                  context,
                  UsersProfilePostView(
                    posts: snapshot,
                    userId: postModel.userId!,
                  ));
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

/**
 * 
    GetBuilder<PostProfileController>(
                builder: (controller) {
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
 */
