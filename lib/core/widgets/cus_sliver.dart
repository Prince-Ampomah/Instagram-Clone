import 'package:flutter/material.dart';

class CustSliverPersistantHeader extends StatelessWidget {
  const CustSliverPersistantHeader({
    Key? key,
    this.pinned = false,
    this.floating = false,
    required this.delegate,
  }) : super(key: key);

  final bool pinned, floating;
  final SliverPersistentHeaderDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: pinned,
      floating: floating,
      delegate: delegate,
    );
  }
}

// sliver header container
class CustomDelegateHeader extends SliverPersistentHeaderDelegate {
  CustomDelegateHeader({required this.child, this.max = 250, this.min = 250});
  final Widget child;
  final double max, min;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
