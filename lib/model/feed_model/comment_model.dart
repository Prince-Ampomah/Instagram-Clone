import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? userHandle;
  String? userProfileImage;
  DateTime? dateTime;

  CommentModel({
    this.userHandle,
    this.userProfileImage,
    this.dateTime,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['userHandle'] = userHandle;
    map['profileImage'] = userProfileImage;
    map['time'] = dateTime;

    return map;
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userHandle: json['userHandle'],
      userProfileImage: json['profileImage'],
      dateTime:
          (json['time'] is Timestamp) ? json['time'].toDate() : json['time'],
    );
  }
}
