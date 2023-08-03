import 'package:cloud_firestore/cloud_firestore.dart';

class ReelCommentModel {
  String? id, reelId;
  String? userHandle;
  String? userProfileImage;
  String? message;
  DateTime? time;
  num? numberOfComments;

  ReelCommentModel({
    this.id,
    this.reelId,
    this.userHandle,
    this.userProfileImage,
    this.time,
    this.numberOfComments,
    this.message,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['reelId'] = reelId;
    map['numberOfComments'] = numberOfComments;
    map['userHandle'] = userHandle;
    map['profileImage'] = userProfileImage;
    map['message'] = message;
    map['time'] = time;

    return map;
  }

  factory ReelCommentModel.fromJson(Map<String, dynamic> json) {
    return ReelCommentModel(
      id: json['id'],
      reelId: json['reelId'],
      numberOfComments: json['numberOfComments'],
      userHandle: json['userHandle'],
      userProfileImage: json['profileImage'],
      message: json['message'],
      time: (json['time'] is Timestamp) ? json['time'].toDate() : json['time'],
    );
  }
}
