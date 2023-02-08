import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme.dart';
import '../../../core/utils/menu_items.dart';
import '../../../core/widgets/cus_popup_menu.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      title: CustomPopUpMenu(
        offset: const Offset(0, 80),
        surfaceTintColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        itemBuilder: MenuItems.homeMenuItems.map((item) {
          return PopupMenuItem<MenuItemModel>(
            height: 35,
            value: item,
            child: Row(
              children: [
                Text(item.text),
                const Spacer(),
                Icon(item.icon),
              ],
            ),
          );
        }).toList(),
        onSelected: (value) async {
          switch (value) {
            case MenuItems.following:
              break;

            default:
              false;
          }
        },
        child: Row(
          children: [
            Image.asset(
              Const.instragramLogoIcon,
              height: 115,
              width: 115,
            ),
            const Icon(Icons.expand_more_outlined, size: 20)
          ],
        ),
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
    );
  }
}
