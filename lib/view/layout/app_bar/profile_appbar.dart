import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/profile_controller/edit_profile_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/theme/theme.dart';
import '../../profile/current_user_profile/profile_view_activity.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0.0,
      title: Row(
        children: [
          GetBuilder<EditProfileController>(
            builder: (_) {
              return Text(
                HiveServices.getUserBox().get(Const.currentUser)!.userHandle ??
                    'userHandle',
                style: AppTheme.textStyle(context).titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              );
            },
          ),
          const Icon(
            Icons.expand_more_outlined,
            size: 20,
            weight: 200,
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Image.asset(
            Const.instragramAddIcon,
            height: 22,
            width: 22,
          ),
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => const ProfileActivity(),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              size: 27,
            ),
          ),
        ),
      ],
    );
  }
}
