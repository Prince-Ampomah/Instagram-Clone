import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/core/constants/constants.dart';

class StoryModel {
  String? id;
  String? userId;
  String? userProfileImage;
  String? userHandle;
  DateTime? timePosted;
  List<dynamic>? media;
  String? storyType;

  StoryModel({
    this.id,
    this.userId,
    this.userProfileImage,
    this.userHandle,
    this.timePosted,
    this.storyType,
    this.media = const [],
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      userId: json['userId'],
      userProfileImage: json['profileImage'],
      userHandle: json['userHandle'],
      timePosted: (json['timePosted'] is Timestamp)
          ? json['timePosted'].toDate()
          : json['timePosted'],
      media: json['media'],
      storyType: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'profileImage': userProfileImage,
      'userHandle': userHandle,
      'media': media,
      'timePosted': timePosted,
      'type': storyType,
    };
  }

  static List<StoryModel> story = [
    StoryModel(
      userProfileImage: Const.userImage,
      userHandle: 'prince_ampomah',
    ),
    StoryModel(
      userProfileImage: Const.princeImage,
      userHandle: 'sandra_i',
    ),
    StoryModel(
      userProfileImage: Const.princeImage,
      userHandle: 'yolo_tv',
    ),
    StoryModel(
      userProfileImage: Const.userImage,
      userHandle: 'somedaywinner',
    ),
  ];
}
