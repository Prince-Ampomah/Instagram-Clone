import 'package:flutter/material.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/core/utils/date_time_convertor.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_circular_image.dart';
import '../../../core/widgets/cus_video_player.dart';
import '../../../model/user_model/user_model.dart';

class ChatVideoBubbleDetails extends StatefulWidget {
  const ChatVideoBubbleDetails({
    super.key,
    required this.videoPath,
    required this.time,
  });

  final String videoPath;
  final DateTime time;

  @override
  State<ChatVideoBubbleDetails> createState() => _ChatVideoBubbleDetailsState();
}

class _ChatVideoBubbleDetailsState extends State<ChatVideoBubbleDetails> {
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    userModel = HiveServices.getUserBox().get(Const.currentUser)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
        title: Row(
          children: [
            if (userModel.profileImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CustomCachedImage(
                  height: 35,
                  width: 35,
                  imageUrl: userModel.profileImage!,
                  fit: BoxFit.cover,
                ),
              )
            else
              CircularImageContainer(
                border: Border.all(width: 1.0),
              ),
            10.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.fullname!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  3.ph,
                  Text(
                    DateTimeConvertor.getTimeAgo(widget.time),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.download_outlined,
                size: 24,
              ),
              tooltip: 'save video',
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CusVideoPlayer(
            videoPath: widget.videoPath,
            showSettingsButton: false,
          ),
        ),
      ),
    );
  }
}
