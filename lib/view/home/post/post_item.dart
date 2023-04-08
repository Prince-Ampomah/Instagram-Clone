import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../model/post_model/post_model.dart';
import '../../../model/user_model/user_model.dart';
import '../../../repository/repository_abstract/database_abstract.dart';
import '../../../repository/respository_implementation/database_implementation.dart';
import 'post_image.dart';
import 'post_reaction.dart';
import 'core/post_user.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    this.postModel,
  });

  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PostUser(
          image: postModel!.userModel!.profileImage,
          userHandle: postModel!.userModel!.userHandle,
        ),
        PostImage(
          images: postModel!.media,
          postModel: postModel,
        ),
        PostReaction(postModel: postModel),
      ],
    );
  }
}


  // Future<UserModel> saveToDB() async {
  //   FirestoreDB firestoreDB = FirestoreDBImpl();



  //   DocumentSnapshot doc = await firestoreDB.getDocById(
  //       Const.usersCollection, 'userModel.userId!');

  //   return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  // }
