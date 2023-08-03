import 'package:flutter/material.dart';

class CustomDraggableSheet extends StatelessWidget {
  const CustomDraggableSheet({
    Key? key,
    this.children,
    this.initialChildSize = 0.1,
    this.minChildSize = 0.1,
    this.maxChildSize = 1.0,
    this.backgroundColor = Colors.white,
    this.controller,
    this.expand = true,
    this.child,
  }) : super(key: key);

  final List<Widget>? children;
  final Widget? child;
  final double? initialChildSize, minChildSize, maxChildSize;

  final Color? backgroundColor;

  final DraggableScrollableController? controller;

  final bool? expand;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: expand!,
        controller: controller,
        initialChildSize: initialChildSize!,
        maxChildSize: maxChildSize!,
        minChildSize: minChildSize!,
        builder: (_, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              controller: scrollController,
              child: child,
            ),
            // (
            //   padding: EdgeInsets.zero,
            //   controller: scrollController,
            //   children: children!,
            // ),
          );
        });
  }
}
