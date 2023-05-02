import 'package:instagram_clone/core/constants/constants.dart';

class StoryModel {
  String? userProfileImage;
  String? userHandle;
  DateTime? timePosted;
  List<dynamic>? media;

  StoryModel({
    this.userProfileImage,
    this.userHandle,
    this.timePosted,
    this.media = const [],
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
        userProfileImage: json['profileImage'],
        userHandle: json['userHandle'],
        timePosted: DateTime(json['timePosted']),
        media: json['media']);
  }

  Map<String, dynamic> toJson() {
    return {
      'profileImage': userProfileImage,
      'userHandle': userHandle,
      'media': media,
      'timePosted': timePosted,
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
