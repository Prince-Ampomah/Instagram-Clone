import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/cus_tab_bar.dart';

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
              GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                children: List.generate(
                  40,
                  (index) => Image.asset(Const.princeImage),
                ),
              ),
              const Center(child: Text('tagged images')),
            ],
          ),
        ),
      ],
    );
  }
}
