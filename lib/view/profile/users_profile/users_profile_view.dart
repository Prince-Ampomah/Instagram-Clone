import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_appbar.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';
import 'package:instagram_clone/view/profile/users_profile/users_profile_view_gallery.dart';
import 'package:instagram_clone/view/profile/users_profile/users_profile_view_info.dart';

import '../../../model/post_model/post_model.dart';

class UsersProfileView extends StatelessWidget {
  const UsersProfileView({
    super.key,
    this.userModel,
    this.postModel,
  });

  final UserModel? userModel;
  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: userModel!.userHandle ?? 'user handle',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: UsersProfileViewInfo(userModel: userModel),
              expandedHeight: size.height * 0.43,
              collapsedHeight: size.height * 0.43,
              scrolledUnderElevation: 0.0,
            ),
          ];
        },
        body: UsersProfileViewGallery(postModel: postModel),
      ),
    );
  }
}
