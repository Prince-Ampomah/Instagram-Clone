import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/date_time_convertor.dart';
import '../../core/widgets/cus_cached_image.dart';
import '../../core/widgets/cus_circular_image.dart';
import '../../core/widgets/cus_rich_text.dart';
import '../../model/post_model/comment_model.dart';

class CommentListItemView extends StatelessWidget {
  const CommentListItemView({super.key, this.snapshot});

  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: snapshot!.data!.docs.length,
      itemBuilder: (BuildContext context, int index) {
        CommentModel commentModel =
            CommentModel.fromJson(snapshot!.data!.docs[index].data());

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commentModel.userProfileImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CustomCachedImage(
                        height: 40,
                        width: 40,
                        imageUrl: commentModel.userProfileImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : CircularImageContainer(
                      height: 0.045,
                      width: 0.045,
                      border: Border.all(width: .2),
                      image: Const.userImage,
                    ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // user handle
                    CustomRichText(
                      text1: '${commentModel.userHandle}  ',
                      text2: DateTimeConvertor.getTimeAgo(
                        commentModel.time ?? DateTime.now(),
                      ),
                      text1Style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 41, 41, 41),
                        fontWeight: FontWeight.w500,
                      ),
                      text2Style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // message
                    if (commentModel.message != null)
                      Text(commentModel.message!),

                    // const SizedBox(height: 10),

                    // const Text('Reply'),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.grey,
                  size: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
