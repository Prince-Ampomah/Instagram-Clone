import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_time_convertor.dart';
import '../../../../core/widgets/cus_bottom_sheet.dart';
import '../../../../core/widgets/cus_cached_image.dart';
import '../../../../core/widgets/cus_circular_image.dart';
import '../../../../core/widgets/cus_list_tile.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({
    super.key,
    required this.isCurrentUserStory,
    this.userImage,
    required this.userHandle,
    required this.timePosted,
  });

  final bool isCurrentUserStory;
  final String? userImage;
  final String userHandle;
  final DateTime timePosted;

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  double percent = 0.0;

  Timer? timer;

  startStoryHighlightTimer() {
    timer = Timer.periodic(
      const Duration(milliseconds: 20),
      (timer) {
        setState(() {
          percent += 0.004;
          if (percent > 1) {
            timer.cancel();
            Navigator.pop(context);
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startStoryHighlightTimer();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
      child: Column(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(50),
          //   child: LinearProgressIndicator(
          //     value: percent,
          //     minHeight: 2,
          //     backgroundColor: Colors.white54,
          //     valueColor: const AlwaysStoppedAnimation(Colors.white),
          //   ),
          // ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    widget.userImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CustomCachedImage(
                              imageUrl: widget.userImage!,
                              fit: BoxFit.cover,
                              height: 35,
                              width: 35,
                            ),
                          )
                        : CircularImageContainer(
                            border: Border.all(
                              width: 1.0,
                              color: Colors.white,
                            ),
                          ),
                    10.pw,
                    Text(
                      widget.userHandle,
                      style: const TextStyle(color: Colors.white),
                    ),
                    10.pw,
                    Text(
                      DateTimeConvertor.getTimeAgo(widget.timePosted),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!widget.isCurrentUserStory)
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return CustomBottomSheetContainer(
                          height: 0.27,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomListTile(
                                onTap: () {},
                                minLeadingWidth: 20,
                                leading: SizedBox(
                                  height: 22,
                                  child: Image.asset(
                                    Const.instragramSendIcon,
                                    color: Colors.black,
                                  ),
                                ),
                                title: "We're moving things around",
                                subTitle: 'See where to share and link',
                                titleStyle: const TextStyle(fontSize: 15),
                                subTitleStyle: const TextStyle(
                                  color: AppColors.buttonColor,
                                  fontSize: 15,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                              const Divider(),
                              // CustomListTile(
                              //   onTap: () {},
                              //   title: "Report...",
                              //   titleStyle: const TextStyle(
                              //     color: Colors.red,
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                              // CustomListTile(
                              //   onTap: () {},
                              //   title: "Mute",
                              //   titleStyle: const TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Report...',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    25.ph,
                                    const Text(
                                      'Mute',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
