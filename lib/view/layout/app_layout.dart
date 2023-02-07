import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/menu_items.dart';
import '../../core/widgets/cus_popup_menu.dart';

import '../../controller/app_layout_controller.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/cus_bottom_nav.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';
import '../reel/reel_view.dart';
import '../search/search_view.dart';
import '../shop/shop_view.dart';

class AppLayoutView extends StatelessWidget {
  AppLayoutView({super.key});

  /// inject an [AppLayoutController] instance in memory
  final appLayoutCtrl = Get.put(AppLayoutController());

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      HomeView(),
      SearchView(),
      ReelView(),
      ShopView(),
      ProfileView(),
    ];

    return GetBuilder<AppLayoutController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Row(
            children: [
              Image.asset(
                Const.instragramLogoIcon,
                height: 115,
                width: 115,
              ),
              const Icon(Icons.expand_more_outlined, size: 20)
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                Const.instragramAddIcon,
                height: 25,
                width: 25,
              ),
            ),
            const Icon(Icons.favorite_outline, size: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                Const.instragramChatIcon,
                height: 25,
                width: 25,
              ),
            ),
          ],
        ),
        bottomNavigationBar: CusDefaultBottomNav(
          currentIndex: appLayoutCtrl.pageIndex,
          elevation: 10.0,
          onTap: appLayoutCtrl.changePageIndex,
        ),
        body: pages[appLayoutCtrl.pageIndex],
      ),
    );
  }
}

    // CustomPopUpMenu(
    //             itemBuilder: MenuItems.homeMenuItems.map((item) {
    //               return PopupMenuItem<MenuItemModel>(
    //                 value: item,
    //                 child: Row(
    //                   children: [
    //                     Text(item.text),
    //                     const SizedBox(width: 12),
    //                     Icon(item.icon),
    //                   ],
    //                 ),
    //               );
    //             }).toList(),
    //             onSelected: (value) async {
    //               switch (value) {
    //                 case MenuItems.following:
    //                   // logOutUser(context);
    //                   break;

    //                 default:
    //               }
    //             },
    //           )