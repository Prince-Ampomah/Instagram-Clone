import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/notification_controller/notification_controller.dart';
import 'package:instagram_clone/core/widgets/cus_appbar.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';
import 'package:instagram_clone/view/notification/notification_list_item.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Notifications',
      ),
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          if (controller.waiting) {
            return const Center(
              child: CustomCircularProgressBar(),
            );
          }

          if (controller.hasError) {
            return Center(
              child: Text(controller.getTextState),
            );
          }

          if (controller.hasData) {
            return NotificationListItem(controller: controller);
          }

          return Center(
            child: Text(controller.getTextState),
          );
        },
      ),
    );
  }
}
