import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/utils/date_time_convertor.dart';
import 'package:instagram_clone/model/notification_model/notification_model.dart';

import '../../controller/notification_controller/notification_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cus_cached_image.dart';
import '../../core/widgets/cus_circular_image.dart';
import '../../core/widgets/cus_rich_text.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    super.key,
    required this.controller,
  });

  final NotificationController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.getNotificationList!.length,
      itemBuilder: (BuildContext context, int index) {
        NotificationModel notificationModel = NotificationModel.fromJson(
          controller.getNotificationList![index].data(),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              notificationModel.userImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CustomCachedImage(
                        height: 50,
                        width: 50,
                        imageUrl: notificationModel.userImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : CircularImageContainer(
                      border: Border.all(width: .7),
                    ),
              15.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                      text1: '${notificationModel.userHandle}, ',
                      text2: 'started following you',
                      text1Style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      text2Style: const TextStyle(
                        color: Color.fromARGB(255, 68, 68, 68),
                      ),
                    ),
                    4.ph,
                    Text(
                      DateTimeConvertor.getTimeAgo(notificationModel.date!),
                    ),
                  ],
                ),
              ),
              15.pw,
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 17,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Follow',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
