import 'package:flutter/material.dart';

import 'package:instagram_clone/core/constants/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/model/reel_model/reel_comment.dart';

import '../../core/utils/date_time_convertor.dart';
import '../../core/widgets/cus_cached_image.dart';
import '../../core/widgets/cus_circular_image.dart';
import '../../core/widgets/cus_circular_progressbar.dart';
import '../../core/widgets/cus_rich_text.dart';

class ReelCommentListView extends StatelessWidget {
  const ReelCommentListView({super.key, required this.reelId});

  final String reelId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection(Const.reelCommentCollection)
          .where('reelId', isEqualTo: reelId)
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomCircularProgressBar());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No comment yet!'));
        }

        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              ReelCommentModel model =
                  ReelCommentModel.fromJson(snapshot.data!.docs[index].data());

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.userProfileImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CustomCachedImage(
                          height: 40,
                          width: 40,
                          imageUrl: model.userProfileImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      CircularImageContainer(
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
                            text1: '${model.userHandle}  ',
                            text2: DateTimeConvertor.getTimeAgo(
                              model.time ?? DateTime.now(),
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
                          if (model.message != null) Text(model.message!),
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

        return Center(child: Text('Something went wrong: ${snapshot.error}'));
      },
    );
  }
}
