import 'package:flutter/material.dart';

class ShopAppBar extends StatelessWidget {
  const ShopAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(scrolledUnderElevation: 0.0, title: const Text('Shop'));
  }
}
