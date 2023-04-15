import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_read_more_text.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/date_time_convertor.dart';
import '../../core/widgets/cus_cached_image.dart';
import '../../core/widgets/cus_circular_image.dart';
import '../../core/widgets/cus_rich_text.dart';

class CommentPostHeader extends StatelessWidget {
  const CommentPostHeader({
    super.key,
    required this.userImage,
    required this.userHandle,
    required this.timePosted,
    required this.caption,
  });

  final String? userImage;
  final String? userHandle;
  final DateTime? timePosted;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomCachedImage(
                    height: 45,
                    width: 45,
                    imageUrl: userImage!,
                    fit: BoxFit.cover,
                  ),
                )
              : const CircularImageContainer(
                  height: 0.04,
                  width: 0.04,
                  image: Const.userImage,
                ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                  text1: '$userHandle  ',
                  text2: DateTimeConvertor.getTimeAgo(
                    timePosted!,
                  ),
                  text2Style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                if (caption != null) CustomReadMore(text: caption!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
