import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class CustomFocusMenu extends StatelessWidget {
  const CustomFocusMenu({
    super.key,
    required this.child,
    required this.onPressed,
    required this.menuItems,
    this.menuOffset = 0,
    this.menuItemExtent = 45,
    this.menuWidth = 0.5,
    this.blurSize = 4.0,
    this.openWithTap = false,
    this.animateMenuItems = false,
  });

  final Widget child;
  final Function onPressed;
  final List<FocusedMenuItem> menuItems;
  final double? menuOffset, menuItemExtent, blurSize;
  final bool? openWithTap, animateMenuItems;
  final num? menuWidth;

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      onPressed: onPressed,
      menuWidth: MediaQuery.sizeOf(context).width * menuWidth!,
      blurSize: blurSize,
      menuItemExtent: menuItemExtent,
      menuOffset: menuOffset,
      menuBoxDecoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      duration: const Duration(milliseconds: 0),
      animateMenuItems: animateMenuItems,
      openWithTap: openWithTap!,
      blurBackgroundColor: Colors.black38,
      menuItems: menuItems,
      child: child,
    );
  }
}
