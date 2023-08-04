import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/widgets/cus.bottom.sheet.icons.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';
import 'package:instagram_clone/core/widgets/cus_list_tile.dart';
import 'package:instagram_clone/core/widgets/cus_text_field_container.dart';
import 'package:instagram_clone/repository/respository_implementation/database_implementation.dart';
import 'package:ionicons/ionicons.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/cus_bottom_sheet.dart';
import '../../core/widgets/cus_cached_image.dart';
import '../../model/user_model/user_model.dart';

class SharePost extends StatelessWidget {
  const SharePost({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetContainer(
      height: 0.75,
      child: Expanded(
        child: Column(
          children: [
            10.ph,
            TextFieldContainer(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              padding: EdgeInsets.zero,
              color: AppColors.searchFieldColor,
              child: TextFormField(
                maxLines: 1,
                minLines: 1,
                textInputAction: TextInputAction.search,
                cursorColor: AppColors.blackColor,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Ionicons.search_outline,
                    color: AppColors.greyColor,
                  ),
                  suffixIcon: Icon(
                    Icons.group_add_outlined,
                    color: AppColors.greyColor,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            10.ph,
            const UsersList(),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
                child: ShareIcons(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  const UsersList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: FirestoreDBImpl.getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List users = snapshot.data.map((doc) => doc.data()).toList();

            return ListView.builder(
              shrinkWrap: false,
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                UserModel userModel = UserModel.fromJson(users[index]);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomListTile(
                    // onTap: () {},
                    leading: userModel.profileImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CustomCachedImage(
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                              imageUrl: userModel.profileImage!,
                            ),
                          )
                        : const SizedBox(),
                    title: userModel.fullname ?? '',
                    subTitle: userModel.userHandle ?? '',
                    // trailing: const Icon(
                    //   Ionicons.ellipse_outline,
                    // ),

                    trailing: Checkbox(
                      onChanged: (value) {},
                      value: false,
                      checkColor: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                  ),
                );
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomCircularProgressBar());
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class ShareIcons extends StatelessWidget {
  const ShareIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CusBottomSheetIcons(
          onTap: () {},
          icons: Ionicons.add_circle_outline,
          text: 'Add to story',
          border: Border.all(width: 0.0, color: Colors.transparent),
          bgColor: AppColors.searchFieldColor,
          textSize: 13,
        ),
        CusBottomSheetIcons(
          onTap: () {},
          icons: Ionicons.share_social_outline,
          text: 'Share',
          border: Border.all(width: 0.0, color: Colors.transparent),
          bgColor: AppColors.searchFieldColor,
          textSize: 13,
        ),
        CusBottomSheetIcons(
          onTap: () {},
          icons: Ionicons.link_outline,
          text: 'Copy link',
          border: Border.all(width: 0.0, color: Colors.transparent),
          bgColor: AppColors.searchFieldColor,
          textSize: 13,
        ),
        CusBottomSheetIcons(
          onTap: () {},
          icons: Ionicons.chatbox_ellipses_outline,
          text: 'SMS',
          border: Border.all(width: 0.0, color: Colors.transparent),
          bgColor: AppColors.searchFieldColor,
          textSize: 13,
        ),
        CusBottomSheetIcons(
          onTap: () {},
          icons: Ionicons.chatbubble_outline,
          text: 'Messenger',
          border: Border.all(width: 0.0, color: Colors.transparent),
          bgColor: AppColors.searchFieldColor,
          textSize: 13,
        ),
        CusBottomSheetIcons(
          onTap: () {},
          icons: Ionicons.logo_whatsapp,
          text: 'WhatsApp',
          border: Border.all(width: 0.0, color: Colors.transparent),
          bgColor: AppColors.searchFieldColor,
          textSize: 13,
        ),
        CusBottomSheetIcons(
          onTap: () {},
          icons: Ionicons.logo_snapchat,
          text: 'Snapchat',
          border: Border.all(width: 0.0, color: Colors.transparent),
          bgColor: AppColors.searchFieldColor,
          textSize: 13,
        ),
        CusBottomSheetIcons(
          onTap: () {},
          icons: Ionicons.logo_facebook,
          text: 'facebook',
          border: Border.all(width: 0.0, color: Colors.transparent),
          bgColor: AppColors.searchFieldColor,
          textSize: 13,
        ),
        CusBottomSheetIcons(
          onTap: () {},
          icons: Ionicons.logo_twitter,
          text: 'Twitter',
          border: Border.all(width: 0.0, color: Colors.transparent),
          bgColor: AppColors.searchFieldColor,
          textSize: 13,
        ),
      ],
    );
  }
}
