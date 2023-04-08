import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/profile_controller/edit_profile_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_appbar.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_circular_image.dart';
import '../../../core/widgets/cus_circular_progressbar.dart';
import '../../../model/user_model/user_model.dart';
import 'edit_bio_view.dart';
import 'edit_name_view.dart';
import 'edit_picture_view.dart';
import 'edit_username_view.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key, this.userInfo});

  final UserModel? userInfo;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
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
          GetBuilder<EditProfileController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () async {
                    await controller
                        .updateProfilePicture(widget.userInfo!.profileImage!);
                  },
                  child: controller.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: CustomCircularProgressBar(
                              valueColor: AppColors.whiteColor,
                              bgColor: AppColors.buttonColor,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.check,
                          size: 30,
                          color: AppColors.buttonColor,
                        ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            15.ph,
            GetBuilder<EditProfileController>(
              builder: (controller) {
                return Column(
                  children: [
                    widget.userInfo!.profileImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CustomCachedImge(
                              height: 95,
                              width: 95,
                              imageUrl: widget.userInfo!.profileImage!,
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
                          builder: (context) => EditPictureView(
                            onCameraTap: () {
                              controller.getUserProfilePic(ImageSource.camera);
                            },
                            onGalleryTap: () {
                              controller.getUserProfilePic(ImageSource.gallery);
                            },
                            onRemovePictureTap: () {},
                          ),
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
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name

                  ListInfoItem(
                    onTap: () => Get.to(
                      () => EditNameView(fullname: widget.userInfo?.fullname),
                    ),
                    title: 'Name',
                    description: widget.userInfo?.fullname,
                  ),

                  const Divider(),

                  8.ph,

                  // username
                  ListInfoItem(
                    onTap: () => Get.to(
                      () => EditUsernameView(
                          username: widget.userInfo?.userHandle),
                    ),
                    title: 'Username',
                    description: widget.userInfo?.userHandle,
                  ),

                  const Divider(),

                  8.ph,

                  // Bio data
                  ListInfoItem(
                    onTap: () => Get.to(
                      () => EditBioView(bio: widget.userInfo?.bio),
                    ),
                    title: 'Bio',
                    description: widget.userInfo?.bio,
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
    this.descriptionMaxLines = 1,
  });

  final Function()? onTap;
  final String? title, description;
  final int? descriptionMaxLines;

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
              maxLines: descriptionMaxLines,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
