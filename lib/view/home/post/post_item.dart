import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../model/post_model/post_model.dart';
import '../../../model/user_model/user_model.dart';
import '../../../repository/repository_abstract/database_abstract.dart';
import '../../../repository/respository_implementation/database_implementation.dart';
import 'post_image.dart';
import 'post_reaction.dart';
import 'post_user.dart';

class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    this.postModel,
  });

  final PostModel? postModel;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  FirestoreDB firestoreDB = FirestoreDBImpl();

  /// Query the user who posted the feed from the [Users] collection in
  /// the database.
  ///
  Future<UserModel> getUserData() async {
    // use post [userId] field to fetch the user the db
    DocumentSnapshot doc = await firestoreDB.getDocById(
      Const.usersCollection,
      widget.postModel!.userId!,
    );

    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<UserModel> userModelsnapshot,
      ) {
        if (userModelsnapshot.hasData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PostUser(
                userModel: userModelsnapshot.data,
                postModel: widget.postModel,
              ),
              PostImage(
                images: widget.postModel!.media,
                postModel: widget.postModel,
              ),
              PostReaction(
                postModel: widget.postModel,
                userModel: userModelsnapshot.data,
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
