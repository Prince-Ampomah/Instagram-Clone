import 'package:flutter/material.dart';

class ReelsAppBar extends StatelessWidget {
  const ReelsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        'Reels',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
