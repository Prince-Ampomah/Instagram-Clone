import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/core/widgets/cus_circular_image.dart';

import '../../model/user_model/user_model.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key,
    this.backgroudColor,
    this.selectedItemColor,
    required this.selectedIndex,
    this.height,
    this.labelBehavior = NavigationDestinationLabelBehavior.alwaysShow,
    this.animationDuration,
    this.onTap,
  });

  final Color? backgroudColor, selectedItemColor;
  final int selectedIndex;
  final double? height;
  final NavigationDestinationLabelBehavior? labelBehavior;
  final Duration? animationDuration;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      animationDuration: animationDuration,
      destinations: bottomItems,
      selectedIndex: selectedIndex,
      onDestinationSelected: onTap,
      backgroundColor: backgroudColor,
      height: height,
    );
  }
}

List<Widget> bottomItems = const [
  NavigationDestination(
      icon: Icon(FontAwesomeIcons.house),
      selectedIcon: Icon(
        FontAwesomeIcons.houseChimney,
      ),
      label: 'Home'),
  NavigationDestination(
      icon: Icon(FontAwesomeIcons.magnifyingGlass),
      selectedIcon: Icon(
        FontAwesomeIcons.magnifyingGlass,
      ),
      label: 'Search'),
  NavigationDestination(
      icon: Icon(FontAwesomeIcons.clapperboard),
      selectedIcon: Icon(
        FontAwesomeIcons.clapperboard,
      ),
      label: 'Reels'),
  NavigationDestination(
      icon: Icon(FontAwesomeIcons.bagShopping),
      selectedIcon: Icon(
        FontAwesomeIcons.bagShopping,
      ),
      label: 'Shop'),
  NavigationDestination(
      icon: Icon(FontAwesomeIcons.user),
      selectedIcon: Icon(
        FontAwesomeIcons.user,
      ),
      label: 'Profile'),
];

class CusDefaultBottomNav extends StatelessWidget {
  const CusDefaultBottomNav({
    super.key,
    required this.currentIndex,
    this.backgroudColor,
    this.selectedItemColor,
    this.height,
    this.elevation,
    this.onTap,
    this.bottomType = BottomNavigationBarType.fixed,
    this.iconSize = 30,
    this.unselectedItemColor,
    this.fixedColor,
  });

  final Color? backgroudColor,
      selectedItemColor,
      unselectedItemColor,
      fixedColor;
  final int currentIndex;
  final double? height, elevation, iconSize;
  final Function(int)? onTap;
  final BottomNavigationBarType? bottomType;

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = HiveServices.getUserBox().get(Const.currentUser);

    List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: '',
        tooltip: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.search_outlined),
        activeIcon: Icon(Icons.search),
        label: '',
        tooltip: 'Search',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.movie_outlined,
        ),
        activeIcon: Icon(
          Icons.movie,
        ),
        label: '',
        tooltip: 'Reel',
      ),
      // const BottomNavigationBarItem(
      //   icon: Icon(
      //     // FontAwesomeIcons.bagShopping,
      //     Icons.shopping_bag_outlined,
      //   ),
      //   activeIcon: Icon(
      //     // FontAwesomeIcons.bagShopping,
      //     Icons.shopping_bag,
      //   ),
      //   label: '',
      //   tooltip: 'Shop',
      // ),
      BottomNavigationBarItem(
        icon: userModel?.profileImage != null
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: .5,
                    color: Colors.black,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomCachedImage(
                    imageUrl: userModel!.profileImage!,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : CircularImageContainer(
                height: 0.04,
                width: 0.04,
                border: Border.all(width: .5),
              ),
        activeIcon: userModel?.profileImage != null
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.black,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomCachedImage(
                    imageUrl: userModel!.profileImage!,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : CircularImageContainer(
                height: 0.04,
                width: 0.04,
                border: Border.all(
                  width: 1.5,
                  color: Colors.black,
                ),
              ),
        label: '',
        tooltip: 'Profile',
      ),
    ];

    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: navItems,
      onTap: onTap,
      elevation: elevation,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      backgroundColor: backgroudColor,
      fixedColor: fixedColor,
      type: bottomType,
      iconSize: iconSize!,
    );
  }
}
