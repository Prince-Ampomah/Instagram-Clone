import 'package:instagram_clone/core/constants/constants.dart';

class StoryModel {
  String? userProfileImage;
  String? userHandle;
  DateTime? timePosted;

  StoryModel({
    this.userProfileImage,
    this.userHandle,
    this.timePosted,
  });

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
