import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/cus_circular_image.dart';

class PostUser extends StatelessWidget {
  const PostUser({
    super.key,
    this.image,
    this.userHandle,
  });

  final String? image, userHandle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            children: [
              image != null
                  ? CustomCachedImge(imageUrl: image!)
                  : CircularImageContainer(
                      image: image,
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(userHandle ?? 'instagram handle'),
                      const SizedBox(width: 5),
                      Image.asset(
                        Const.instragramVerifiedIcon,
                        height: 15,
                        width: 15,
                      ),

                      // Container(
                      //   height: 15,
                      //   width: 15,
                      //   decoration: const BoxDecoration(
                      //       color: Colors.blue,
                      //       shape: BoxShape.circle),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(20),
                      //     child: const Icon(
                      //       Icons.check,
                      //       color: Colors.white,
                      //       size: 10,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  const Text('location'),
                ],
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_vert)
        ],
      ),
    );
  }
}
