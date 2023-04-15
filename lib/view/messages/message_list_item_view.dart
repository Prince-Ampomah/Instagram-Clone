import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';

import '../../core/widgets/cus_cached_image.dart';
import '../../core/widgets/cus_circular_image.dart';
import 'chat_room/chat_room_view.dart';

class MessageListItem extends StatelessWidget {
  const MessageListItem({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot<dynamic> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: snapshot.data.docs.length,
      itemBuilder: (BuildContext context, int index) {
        UserModel userModel =
            UserModel.fromJson(snapshot.data.docs[index].data());

        return InkWell(
          onTap: () {
            sendToPage(context, ChatRoomView(userModel: userModel));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              children: [
                userModel.profileImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CustomCachedImage(
                          height: 57,
                          width: 57,
                          imageUrl: userModel.profileImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : CircularImageContainer(
                        height: 0.07,
                        width: 0.07,
                        border: Border.all(width: 1.0),
                      ),
                20.pw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel.fullname!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      5.ph,
                      const Text(
                        'Recent Message',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.grey,
                    size: 27,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
