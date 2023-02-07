import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({
    this.leadingIcon,
    this.title,
    this.actions,
    this.implyLeading = false,
    this.centerTitle,
    this.bgColor,
    this.titleColor,
    this.titleStyle,
    this.bottom,
    this.elevation = 0.0,
    Key? key,
  }) : super(key: key);

  final Widget? leadingIcon;
  final String? title;
  final List<Widget>? actions;
  final bool implyLeading;
  final double? elevation;
  final bool? centerTitle;
  final Color? bgColor, titleColor;
  final PreferredSizeWidget? bottom;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: implyLeading,
        backgroundColor: bgColor,
        elevation: elevation,
        leading: leadingIcon,
        title: Text(
          title ?? '',
          style: titleStyle ?? TextStyle(color: titleColor),
        ),
        centerTitle: centerTitle,
        actions: actions,
        bottom: bottom);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
