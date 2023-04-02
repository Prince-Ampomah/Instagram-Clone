import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? id, postId;
  String? userHandle;
  String? userProfileImage;
  String? message;
  DateTime? time;
  num? numberOfComments;

  CommentModel({
    this.id,
    this.postId,
    this.userHandle,
    this.userProfileImage,
    this.time,
    this.numberOfComments,
    this.message,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['postId'] = postId;
    map['numberOfComments'] = numberOfComments;
    map['userHandle'] = userHandle;
    map['profileImage'] = userProfileImage;
    map['message'] = message;
    map['time'] = time;

    return map;
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      numberOfComments: json['numberOfComments'],
      userHandle: json['userHandle'],
      userProfileImage: json['profileImage'],
      message: json['message'],
      time: (json['time'] is Timestamp) ? json['time'].toDate() : json['time'],
    );
  }
}
