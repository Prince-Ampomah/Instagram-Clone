import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';

import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_circular_image.dart';
import '../../../model/user_model/user_model.dart';

class ChatRoomAppBar extends StatelessWidget {
  const ChatRoomAppBar({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      scrolledUnderElevation: 0.0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          userModel.profileImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomCachedImage(
                    height: 35,
                    width: 35,
                    imageUrl: userModel.profileImage!,
                    fit: BoxFit.cover,
                  ),
                )
              : CircularImageContainer(
                  border: Border.all(width: 1.0),
                ),
          10.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.fullname!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                3.ph,
                const Text(
                  'Active today',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.phone_outlined,
            size: 27,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.video_camera_front_outlined,
              size: 27,
            ),
          ),
        ),
      ],
    );
  }
}
