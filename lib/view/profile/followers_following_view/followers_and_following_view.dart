import 'package:flutter/material.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:instagram_clone/core/widgets/cus_tab.dart';
import 'package:instagram_clone/core/widgets/cus_tab_bar.dart';
import 'package:instagram_clone/view/profile/followers_following_view/list_followers.dart';
import 'package:instagram_clone/view/profile/followers_following_view/list_following.dart';

import '../../../model/user_model/user_model.dart';

class FollowersAndFollowingView extends StatefulWidget {
  const FollowersAndFollowingView({
    super.key,
    this.userModel,
    this.pageIndex = 0,
  });

  final UserModel? userModel;
  final int? pageIndex;

  @override
  State<FollowersAndFollowingView> createState() =>
      _FollowersAndFollowingViewState();
}

class _FollowersAndFollowingViewState extends State<FollowersAndFollowingView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.animateTo(widget.pageIndex!);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userModel?.userHandle ?? 'user'),
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.whiteColor,
        bottom: CustomTabBar(
          tabController: tabController,
          indicatorWeight: .6,
          labelColor: AppColors.blackColor,
          indicatorColor: AppColors.blackColor,
          unselectedLabelColor: const Color(0xFFA7A7A7),
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            CustomTab(
              tabName: widget.userModel!.listOfFollowers!.length <= 1
                  ? '${widget.userModel!.listOfFollowers!.length} Follower'
                  : '${widget.userModel!.listOfFollowers!.length} Followers',
            ),
            CustomTab(
              tabName: '${widget.userModel!.listOfFollowing!.length} Following',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ListFollowers(userModel: widget.userModel!),
          ListFollowing(userModel: widget.userModel!),
        ],
      ),
    );
  }
}
