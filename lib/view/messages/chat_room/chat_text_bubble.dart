import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/modals.dart';
import 'package:instagram_clone/controller/chat_controller/chat_controller.dart';
import 'package:instagram_clone/controller/models_controller/models_controller.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/view/profile/users_profile/users_profile_view.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_focus_menu.dart';
import '../../../core/widgets/cus_read_more_text.dart';
import '../../../model/chat_model/chat_model.dart';

class ChatBubbleTextMessage extends StatelessWidget {
  const ChatBubbleTextMessage({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    bool isMe = chatModel.senderId == FirebaseAuth.instance.currentUser!.uid;

    return CustomFocusMenu(
      onPressed: () {},
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
          onPressed: () {},
          title: const Text('Reply'),
          trailingIcon: const Icon(Icons.reply_outlined),
        ),
        FocusedMenuItem(
          onPressed: () {},
          title: const Text('Forward'),
          trailingIcon: const Icon(Icons.near_me_outlined),
        ),
        FocusedMenuItem(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: chatModel.message!));
            showToast(msg: 'Text Copied');
          },
          title: const Text('Copy'),
          trailingIcon: const Icon(Icons.copy_outlined),
        ),
        FocusedMenuItem(
          onPressed: () {
            ChatController.instance.deleteChatMessage(chatModel.messageId!);
          },
          title: const Text(
            'Unsend',
            style: TextStyle(color: Colors.redAccent),
          ),
          trailingIcon: const Icon(
            Icons.delete_outline,
            color: Colors.redAccent,
          ),
        ),
      ],
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && chatModel.receiverImage != null)
            GestureDetector(
              onTap: () {
                sendToPage(
                  context,
                  UsersProfileView(
                    userModel: ChatController.instance.receiverModel,
                    postModel: ModelController.instance.postModel,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomCachedImage(
                    height: 30,
                    width: 30,
                    imageUrl: chatModel.receiverImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                right: isMe ? 10.0 : 80.0,
                left: isMe ? 80.0 : 10.0,
                bottom: 10.0,
              ),
              padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
              decoration: BoxDecoration(
                color: isMe ? AppColors.chatColor : AppColors.buttonBgColor,
                borderRadius: isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
              ),
              child: CustomReadMore(
                text: chatModel.message!,
                textStyle: TextStyle(
                  color: isMe ? AppColors.whiteColor : AppColors.blackColor,
                ),
                trimLines: 4,
                readMoreText: ' Read More',
                readLessText: ' Read Less',
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// return CustomPopUpMenu(
//   offset: const Offset(80, 30),
//   surfaceTintColor: AppColors.whiteColor,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(8),
//   ),
//   itemBuilder: MenuItems.homeMenuItems.map((item) {
//     return PopupMenuItem<MenuItemModel>(
//       height: 50,
//       value: item,
//       child: Row(
//         children: [
//           Text(item.text),
//           const Spacer(),
//           Icon(item.icon),
//         ],
//       ),
//     );
//   }).toList(),
//   onSelected: (value) async {
//     switch (value) {
//       case MenuItems.following:
//         break;

//       default:
//         false;
//     }
//   },

//   child:

//    Row(
//     mainAxisAlignment:
//         isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.end,
//     children: [
//       if (!isMe && chatModel.receiverImage != null)
//         GestureDetector(
//           onTap: () {
//             sendToPage(
//               context,
//               UsersProfileView(
//                 userModel: ChatController.instance.receiverModel,
//                 postModel: ModelController.instance.postModel,
//               ),
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: CustomCachedImage(
//                 height: 30,
//                 width: 30,
//                 imageUrl: chatModel.receiverImage!,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//       Flexible(
//         child: Container(
//           margin: EdgeInsets.only(
//             right: isMe ? 10.0 : 80.0,
//             left: isMe ? 80.0 : 10.0,
//             bottom: 10.0,
//           ),
//           padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
//           decoration: BoxDecoration(
//             color: isMe ? AppColors.chatColor : AppColors.buttonBgColor,
//             borderRadius: isMe
//                 ? const BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15),
//                     bottomLeft: Radius.circular(15),
//                     bottomRight: Radius.circular(15),
//                   )
//                 : const BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15),
//                     bottomRight: Radius.circular(15),
//                     bottomLeft: Radius.circular(15),
//                   ),
//           ),
//           child: CustomReadMore(
//             text: chatModel.message!,
//             textStyle: TextStyle(
//               color: isMe ? AppColors.whiteColor : AppColors.blackColor,
//             ),
//             trimLines: 4,
//             readMoreText: ' Read More',
//             readLessText: ' Read Less',
//           ),
//         ),
//       ),
//     ],
//   ),

// );

        // final RenderBox overlay =
        //     Overlay.of(context).context.findRenderObject() as RenderBox;
        // showMenu(
        //   surfaceTintColor: AppColors.whiteColor,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   context: context,
        //   position: RelativeRect.fromRect(
        //     Rect.fromPoints(
        //       overlay.localToGlobal(Offset.zero),
        //       overlay.localToGlobal(overlay.size.bottomRight(Offset.zero)),
        //     ),
        //     Offset.zero & overlay.size,
        //   ),
        //   items: const [
        //     PopupMenuItem(
        //       value: 'reply',
        //       child: Text('Reply'),
        //     ),
        //     PopupMenuItem(
        //       value: 'forward',
        //       child: Text('Forward'),
        //     ),
        //     PopupMenuItem(
        //       value: 'delete',
        //       child: Text('Delete'),
        //     )
        //   ],
        // );