import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/app_layout_controller/app_layout_controller.dart';
import '../../core/widgets/cus_bottom_nav.dart';
import '../home/home_view.dart';
import '../profile/current_user_profile/profile_view.dart';
import '../reel/reel_view.dart';
import '../search/search_view.dart';
import 'app_bar/home_appbar.dart';
import 'app_bar/profile_appbar.dart';
import 'app_bar/reels_appbar.dart';
import 'app_bar/search_appbar.dart';

class AppLayoutView extends StatefulWidget {
  const AppLayoutView({super.key, this.pageIndex = 0});

  final int? pageIndex;

  @override
  State<AppLayoutView> createState() => _AppLayoutViewState();
}

class _AppLayoutViewState extends State<AppLayoutView> {
  /// inject an [AppLayoutController] instance in memory
  final appLayoutCtrl = Get.put(AppLayoutController());

  @override
  void initState() {
    super.initState();
    // update the current page
    appLayoutCtrl.pageIndex = widget.pageIndex!;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      HomeView(),
      SearchView(),
      ReelView(),
      // ShopView(),
      ProfileView(),
    ];

    /// switch app bar when bottom item is tapped
    Widget getAppBar(pageIndex) {
      switch (pageIndex) {
        case 0:
          return const HomeAppBar();
        case 1:
          return const SearchAppBar();
        case 2:
          return const ReelsAppBar();
        // case 3:
        //   return const ShopAppBar();
        default:
          return const ProfileAppBar();
      }
    }

    return GetBuilder<AppLayoutController>(
      builder: (_) => Scaffold(
        extendBodyBehindAppBar: appLayoutCtrl.pageIndex != 2 ? false : true,
        backgroundColor: appLayoutCtrl.pageIndex != 2
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.transparent.withOpacity(0.2),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: getAppBar(appLayoutCtrl.pageIndex),
        ),
        bottomNavigationBar: CusDefaultBottomNav(
          currentIndex: appLayoutCtrl.pageIndex,
          onTap: appLayoutCtrl.changePageIndex,
          elevation: 5.0,
          backgroudColor: appLayoutCtrl.pageIndex == 2 ? Colors.black : null,
          selectedItemColor:
              appLayoutCtrl.pageIndex != 2 ? Colors.black : Colors.white,
          unselectedItemColor: appLayoutCtrl.pageIndex != 2
              ? null
              : const Color.fromARGB(255, 189, 189, 189),
        ),
        body: pages[appLayoutCtrl.pageIndex],
      ),
    );
  }
}
