import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: List.generate(
        40,
        (index) => Image.asset(Const.princeImage),
      ),
    );
  }
}
