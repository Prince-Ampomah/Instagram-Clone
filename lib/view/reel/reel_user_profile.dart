import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:instagram_clone/controller/follow_controller/follow_controller.dart';
import 'package:instagram_clone/controller/reel_controller/reel_controller.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/core/widgets/cus_circular_image.dart';
import 'package:instagram_clone/core/widgets/cus_primary_button.dart';
import 'package:instagram_clone/core/widgets/cus_read_more_text.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';

import '../../app_state.dart';
import '../../core/services/hive_services.dart';

class ReelUserProfile extends StatefulWidget {
  const ReelUserProfile({
    super.key,
    required this.userId,
    this.reelCaption,
  });

  final String userId;
  final String? reelCaption;

  @override
  State<ReelUserProfile> createState() => _ReelUserProfileState();
}

class _ReelUserProfileState extends State<ReelUserProfile> {
  UserModel reelUser = UserModel();

  late UserModel _currentUser;

  @override
  void initState() {
    super.initState();
    getUserData();
    _currentUser = AppState.currentUser!;
  }

  getUserData() async {
    reelUser = await ReelController.instance.getReelUserData(
      userId: widget.userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (reelUser.userId != null) {
      return Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 100, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (reelUser.profileImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CustomCachedImage(
                        height: 40,
                        width: 40,
                        imageUrl: reelUser.profileImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    CircularImageContainer(
                      border: Border.all(
                        width: 1.0,
                        color: Colors.white,
                      ),
                    ),
                  5.pw,
                  Text(
                    reelUser.userHandle!,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.whiteColor),
                  ),
                  20.pw,
                  if (_currentUser.userId != reelUser.userId)
                    ValueListenableBuilder<Box<UserModel>>(
                      valueListenable: HiveServices.getUserBox().listenable(),
                      builder: (BuildContext context, currentUserBox, _) {
                        bool isInFollowersList = currentUserBox
                            .get(Const.currentUser)!
                            .listOfFollowing!
                            .contains(reelUser.userId!);

                        if (!isInFollowersList) {
                          return PrimaryOutlinedButton(
                            onPressed: () {
                              FollowController.instance
                                  .followUser(reelUser.userId!);
                            },
                            title: 'Follow',
                            borderRadius: 8,
                            buttonHeight: 30,
                            textColor: Colors.white,
                            borderSideColor: Colors.white,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                ],
              ),
              20.ph,
              if (widget.reelCaption != null)
                CustomReadMore(
                  text: widget.reelCaption!,
                  readMoreText: 'more',
                  trimLines: 1,
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.whiteColor),
                ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Remote Jobs - requires no talking',
              //         style: Theme.of(context)
              //             .textTheme
              //             .labelMedium!
              //             .copyWith(color: AppColors.whiteColor),
              //       ),
              //       const SizedBox(height: 10),
              //       Row(
              //         children: [
              //           const Icon(
              //             Icons.sort_rounded,
              //             color: Colors.white,
              //           ),
              //           const SizedBox(width: 10),
              //           Text(
              //             'sarkcess music prod...',
              //             style:
              //                 AppTheme.textStyle(context).labelMedium!.copyWith(
              //                       color: AppColors.whiteColor,
              //                     ),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
