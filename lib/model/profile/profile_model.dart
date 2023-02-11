import 'package:instagram_clone/model/story/story_model.dart';

class ProfileModel {
  final String userProfileImage;
  final String username;
  final String? caption;
  final double numberOfPost;
  final double numberOfFollowers;
  final double numberOfFollowing;
  final StoryModel? yourStories;

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
