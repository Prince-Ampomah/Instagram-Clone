import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/constants.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/cus_appbar.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_circular_image.dart';
import '../../../model/user_model/user_model.dart';
import 'edit_bio_view.dart';
import 'edit_name_view.dart';
import 'edit_picture_view.dart';
import 'edit_username_view.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? userInfo = HiveServices.getUserBox().get(Const.currentUser);

    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Edit Profile',
        titleStyle: const TextStyle(fontWeight: FontWeight.bold),
        leadingIcon: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.clear, size: 30),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check,
                size: 30,
                color: AppColors.buttonColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            15.ph,
            Column(
              children: [
                userInfo!.profileImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CustomCachedImge(
                          height: 95,
                          width: 95,
                          imageUrl: userInfo.profileImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : CircularImageContainer(
                        height: 0.1,
                        width: 0.1,
                        border: Border.all(width: 0.5),
                      ),
                10.ph,
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const EditPictureView(),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Edit Picture',
                      style: TextStyle(color: AppColors.buttonColor),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name

                  ListInfoItem(
                    onTap: () => Get.to(
                      () => EditNameView(fullname: userInfo.fullname),
                    ),
                    title: 'Name',
                    description: userInfo.fullname,
                  ),

                  const Divider(),

                  8.ph,

                  // username
                  ListInfoItem(
                    onTap: () => Get.to(
                      () => EditUsernameView(username: userInfo.userHandle),
                    ),
                    title: 'Username',
                    description: userInfo.userHandle,
                  ),

                  const Divider(),

                  8.ph,

                  // Bio data
                  ListInfoItem(
                    onTap: () => Get.to(() => const EditBioView()),
                    title: 'Bio',
                    description: userInfo.bio,
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListInfoItem extends StatelessWidget {
  const ListInfoItem({
    super.key,
    this.onTap,
    required this.title,
    this.description,
  });

  final Function()? onTap;
  final String? title, description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashFactory: NoSplash.splashFactory,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            8.ph,
            Text(
              description ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
