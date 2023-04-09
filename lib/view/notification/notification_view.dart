import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:instagram_clone/core/widgets/cus_appbar.dart';
import 'package:instagram_clone/core/widgets/cus_circular_image.dart';
import 'package:instagram_clone/core/widgets/cus_main_button.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Notifications',
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const CircularImageContainer(),
                15.pw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Title'),
                      2.ph,
                      const Text('5h'),
                    ],
                  ),
                ),
                const AppButton(
                  title: 'Follow',
                  bgColor: AppColors.buttonColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
