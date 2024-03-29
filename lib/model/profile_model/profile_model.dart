import 'package:instagram_clone/model/story_model/story_model.dart';

class ProfileModel {
  String userProfileImage;
  String username;
  String? caption;
  num numberOfPost;
  num numberOfFollowers;
  num numberOfFollowing;
  StoryModel? yourStories;

  ProfileModel({
    required this.userProfileImage,
    required this.username,
    this.caption,
    this.numberOfPost = 0,
    this.numberOfFollowers = 0,
    this.numberOfFollowing = 0,
    this.yourStories,
  });
}
