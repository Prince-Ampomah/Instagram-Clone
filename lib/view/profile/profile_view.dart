import 'package:flutter/material.dart';
import 'package:instagram_clone/view/profile/profile_view_gallery.dart';
import 'package:instagram_clone/view/profile/profile_view_info.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NestedScrollView(
      physics: const NeverScrollableScrollPhysics(),
      headerSliverBuilder: (context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            flexibleSpace: const ProfileViewInfo(),
            expandedHeight: size.height * 0.48,
            collapsedHeight: size.height * 0.48,
            scrolledUnderElevation: 0.0,
          ),
        ];
      },
      body: const ProfileViewGallery(),
    );
  }
}
