import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';

class ShopAppBar extends StatelessWidget {
  const ShopAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0.0,
      title: Container(
        width: width,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Search shops',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.grey),
        ),
      ),

      // Text(
      //   'Shop',
      //   style: Theme.of(context)
      //       .textTheme
      //       .titleLarge!
      //       .copyWith(fontWeight: FontWeight.bold),
      // ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.book_outlined,
          ),
        ),
        IconButton(
          onPressed: () {
            Get.bottomSheet(
              Container(
                height: 900,
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.menu,
          ),
        ),
      ],
    );
  }
}
