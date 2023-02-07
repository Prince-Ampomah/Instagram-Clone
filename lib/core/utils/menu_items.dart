import 'package:flutter/material.dart';

class MenuItemModel {
  final String text;
  final IconData icon;

  const MenuItemModel({required this.text, required this.icon});
}

class MenuItems {
  // home appbar pop menu item
  static const following =
      MenuItemModel(text: 'Following', icon: Icons.people_outline);
  static const favorites =
      MenuItemModel(text: 'Favorites', icon: Icons.star_border);

  static const List<MenuItemModel> homeMenuItems = [following, favorites];
}
