import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      this.onTap,
      this.icon,
      required this.title,
      this.subTitle,
      this.trailing,
      this.minLeadingWidth,
      this.leading,
      this.titleStyle,
      this.subTitleStyle})
      : super(key: key);

  final IconData? icon;
  final String title;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final double? minLeadingWidth;
  final TextStyle? titleStyle, subTitleStyle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListTile(
        onTap: onTap,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        minLeadingWidth: minLeadingWidth,
        leading: leading,
        title: Text(title, style: titleStyle),
        subtitle: Text(
          subTitle ?? '',
          style: subTitleStyle,
        ),
        trailing: trailing,
      ),
    );
  }
}
