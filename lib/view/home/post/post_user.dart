import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';

import '../../../core/constants/constants.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/widgets/cus_circular_image.dart';
import '../../../model/user_model/user_model.dart';

class PostUser extends StatelessWidget {
  const PostUser({
    super.key,
    // this.image,
    // this.userHandle,
    this.userModel,
  });

  // final String? image, userHandle;
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            children: [
              userModel!.profileImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CustomCachedImge(
                        height: 40,
                        width: 40,
                        imageUrl: userModel!.profileImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const CircularImageContainer(image: Const.userImage),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        // userHandle ?? 'instagram handle',
                        userModel!.userHandle ?? 'instagram handle',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
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
                      //       color: Colors.blue, shape: BoxShape.circle),
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
