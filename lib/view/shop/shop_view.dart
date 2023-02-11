import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    // return NestedScrollView(
    //   physics: const BouncingScrollPhysics(),
    //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //     return [
    //       SliverAppBar.medium(
    //         floating: true,
    //         scrolledUnderElevation: 0.0,
    //         title: Container(
    //           width: double.infinity,
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 15,
    //             vertical: 8,
    //           ),
    //           decoration: BoxDecoration(
    //             color: Colors.grey[200],
    //             borderRadius: BorderRadius.circular(10),
    //           ),
    //           child: Text(
    //             'Search shops',
    //             style: Theme.of(context)
    //                 .textTheme
    //                 .titleSmall!
    //                 .copyWith(color: Colors.grey),
    //           ),
    //         ),
    //       )
    //     ];
    //   },
    //   body: GridView.count(
    //     crossAxisCount: 2,
    //     mainAxisSpacing: 1.0,
    //     crossAxisSpacing: 1.0,
    //     children: List.generate(
    //       20,
    //       (index) => Image.asset(Const.princeImage),
    //     ),
    //   ),
    // );

    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: List.generate(
        30,
        (index) => Image.asset(Const.princeImage),
      ),
    );
  }
}
