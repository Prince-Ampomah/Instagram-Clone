import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/core/widgets/cus_video_player.dart';
import 'package:instagram_clone/view/home/home_view.dart';
import 'package:instagram_clone/view/messages/core/chat_preview_video.dart';
import 'package:instagram_clone/view/messages/message_view.dart';
import 'package:instagram_clone/view/notification/notification_view.dart';

import '../../../controller/post_controller/new_post_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/menu_items.dart';
import '../../../core/widgets/cus_popup_menu.dart';
import '../../add_post/add_new_post_camera_view.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0.0,
      title: CustomPopUpMenu(
        offset: const Offset(0, 80),
        surfaceTintColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        itemBuilder: MenuItems.homeMenuItems.map((item) {
          return PopupMenuItem<MenuItemModel>(
            height: 35,
            value: item,
            child: Row(
              children: [
                Text(item.text),
                const Spacer(),
                Icon(item.icon),
              ],
            ),
          );
        }).toList(),
        onSelected: (value) async {
          switch (value) {
            case MenuItems.following:
              break;

            default:
              false;
          }
        },
        child: Row(
          children: [
            Image.asset(
              Const.instragramLogoIcon,
              height: 115,
              width: 115,
            ),
            const Icon(Icons.expand_more_outlined, size: 20)
          ],
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            Get.put(NewPostController());
            sendToPage(context, const NewPostCameraView());
            // await NewPostController.instance.pickMediaFromDevice();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              Const.instragramAddIcon,
              height: 25,
              width: 25,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Get.to(() => const NotificationView());
            sendToPage(
              context,
              ChatPreviewVideo(videoPath: videoUrlPortrait),
            );
          },
          child: const Icon(Icons.favorite_outline, size: 30),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const MessageView());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              Const.instragramChatIcon,
              height: 25,
              width: 25,
            ),
          ),
        ),
      ],
    );
  }
}
