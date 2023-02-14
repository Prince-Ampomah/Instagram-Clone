import '../user_model/user_model.dart';

class PostGalleryModel {
  String? caption;
  List<dynamic> media;
  UserModel? userModel;
  LikesModel? likesModel;
  CommentModel? commentModel;

  PostGalleryModel({
    required this.media,
    required this.userModel,
    this.caption,
    this.likesModel,
    this.commentModel,
  });
}

class LikesModel {
  int likes;

  LikesModel({
    required this.likes,
  });
}

class CommentModel {
  String? userHandle;
  String? userProfileImage;
  DateTime? dateTime;

  CommentModel({
    this.userHandle,
    this.userProfileImage,
    this.dateTime,
  });
}
