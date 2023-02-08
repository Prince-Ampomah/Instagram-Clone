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
    this.surfaceTintColor,
    this.offset = Offset.zero,
    this.position,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);
  final List<PopupMenuEntry<dynamic>> itemBuilder;
  final Function(dynamic)? onSelected;
  final Widget? icon;
  final Widget? child;
  final Color? color, surfaceTintColor;
  final ShapeBorder? shape;
  final Offset offset;
  final PopupMenuPosition? position;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: color,
      surfaceTintColor: surfaceTintColor,
      position: position,
      shape: shape,
      padding: padding,
      icon: icon,
      offset: offset,
      itemBuilder: (BuildContext context) => itemBuilder,
      onSelected: onSelected,
      child: child,
    );
  }
}
