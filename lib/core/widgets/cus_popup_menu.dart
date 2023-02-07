import 'package:flutter/material.dart';

class CustomPopUpMenu extends StatelessWidget {
  const CustomPopUpMenu({
    Key? key,
    required this.itemBuilder,
    this.onSelected,
    this.icon,
    this.child,
    this.color,
    this.shape,
  }) : super(key: key);
  final List<PopupMenuEntry<dynamic>> itemBuilder;
  final Function(dynamic)? onSelected;
  final Widget? icon;
  final Widget? child;
  final Color? color;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: color,
      shape: shape,
      icon: icon,
      itemBuilder: (BuildContext context) => itemBuilder,
      onSelected: onSelected,
      child: child,
    );
  }
}
