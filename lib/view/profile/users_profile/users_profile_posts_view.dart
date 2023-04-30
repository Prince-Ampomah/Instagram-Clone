import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/cus_appbar.dart';
import '../../../model/post_model/post_model.dart';
import '../../../model/user_model/user_model.dart';
import '../../../repository/repository_abstract/database_abstract.dart';
import '../../../repository/respository_implementation/database_implementation.dart';
import '../../home/post/post_image.dart';
import '../../home/post/post_reaction.dart';
import '../../home/post/post_user.dart';
import '../../home/post/post_video.dart';

class UsersProfilePostView extends StatefulWidget {
  const UsersProfilePostView({super.key, this.posts, required this.userId});

  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? posts;
  final String userId;

  @override
  State<UsersProfilePostView> createState() => _UsersProfilePostViewState();
}

class _UsersProfilePostViewState extends State<UsersProfilePostView> {
  FirestoreDB firestoreDB = FirestoreDBImpl();

  /// Query the user who posted the feed from the [Users] collection in
  /// the database.
  ///
  Future<UserModel> getUserData() async {
    // use post [userId] field to fetch the user the db
    DocumentSnapshot doc = await firestoreDB.getDocById(
      Const.usersCollection,
      widget.userId,
    );

    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Posts',
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: widget.posts!.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                PostModel postModel =
                    PostModel.fromJson(widget.posts!.data!.docs[index].data());
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PostUser(
                        userModel: snapshot.data,
                        postModel: postModel,
                      ),
                      postModel.postType == Const.videoPostType
                          ? PostVideoView(
                              video: postModel.media,
                              postModel: postModel,
                            )
                          : PostImage(
                              images: postModel.media,
                              postModel: postModel,
                            ),
                      PostReaction(
                        postModel: postModel,
                        userModel: snapshot.data,
                      ),
                    ],
                  ),
                );
              },
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomCircularProgressBar());
          }

          return const SizedBox();
        },
      ),
    );
  }
}
