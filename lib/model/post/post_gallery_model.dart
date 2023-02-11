import '../user_model.dart';

class PostGalleryModel {
  final String? caption;
  final List<dynamic> media;
  final UserModel? userModel;
  final LikesModel? likesModel;
  final CommentModel? commentModel;

  PostGalleryModel({
    required this.media,
    required this.userModel,
    this.caption,
    this.likesModel,
    this.commentModel,
  });
}

class LikesModel {
  final int likes;

  LikesModel({
    required this.likes,
  });
}

class CommentModel {
  final String? userHandle;
  final String? userProfileImage;
  final DateTime? dateTime;

  CommentModel({
    this.userHandle,
    this.userProfileImage,
    this.dateTime,
  });
}
