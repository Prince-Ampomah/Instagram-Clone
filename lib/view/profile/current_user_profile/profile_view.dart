import 'package:flutter/material.dart';
import 'profile_view_gallery.dart';
import 'profile_view_info.dart';

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
            automaticallyImplyLeading: false,
            flexibleSpace: const ProfileViewInfo(),
            expandedHeight: size.height * 0.43,
            collapsedHeight: size.height * 0.43,
            scrolledUnderElevation: 0.0,
          ),
        ];
      },
      body: const ProfileViewGallery(),
    );
  }
}
