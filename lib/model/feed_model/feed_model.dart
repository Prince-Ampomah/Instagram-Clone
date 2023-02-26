import 'package:instagram_clone/controller/auth_controller/auth_controller.dart';

import '../../core/constants/constants.dart';
import '../user_model/user_model.dart';
import 'comment_model.dart';
import 'like_model.dart';

class FeedModel {
  String id;
  String? caption;
  List<dynamic> media;
  UserModel? userModel;
  LikeModel? likeModel;
  CommentModel? commentModel;

  FeedModel({
    required this.id,
    required this.media,
    required this.userModel,
    this.caption,
    this.likeModel,
    this.commentModel,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['capton'] = caption;
    map['media'] = media;
    map['user'] = userModel!.toJson();
    map['likes'] = likeModel!.toJson();
    map['comments'] = commentModel!.toJson();

    return map;
  }

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
        id: json['id'],
        caption: json['caption'],
        media: json['media'],
        userModel: UserModel.fromJson(json['user']),
        likeModel: LikeModel.fromJson(json['likes']),
        commentModel: CommentModel.fromJson(json['comments']));
  }

  static List<FeedModel> feed = [
    FeedModel(
      id: '1',
      media: [Const.princeImage],
      userModel: UserModel(
        userHandle: 'sandisca_',
        userId: '1',
        profileImage: Const.userImage,
      ),
      caption: 'Let us build an instagram together Fellas!',
      likeModel: LikeModel(
        id: 'id1',
        likes: 10,
      ),
      commentModel: CommentModel(
        userHandle: '_goodMeagan_',
        userProfileImage: Const.userImage,
        dateTime: DateTime.now(),
      ),
    ),
    FeedModel(
      id: '2',
      media: [
        Const.instragramLogoIcon,
      ],
      userModel: AuthController.instance.userModel,
      caption: 'Don\'t ever give up on anything!!!!',
      likeModel: LikeModel(
        id: 'id1',
        likes: 1000,
      ),
      commentModel: CommentModel(
        userHandle: 'Apostel_Sulman',
        userProfileImage: Const.instragramShopIcon,
        dateTime: DateTime.now(),
      ),
    ),
    FeedModel(
      id: '2',
      media: [
        Const.userImage,
      ],
      userModel: AuthController.instance.userModel,
      caption: 'They thought they buried us but they did\'t know were seeds',
      likeModel: LikeModel(
        id: 'id1',
        likes: 250,
      ),
      commentModel: CommentModel(
        userHandle: 'somedaywinner',
        userProfileImage: Const.princeImage,
        dateTime: DateTime.now(),
      ),
    ),
    FeedModel(
      id: '1',
      media: [
        Const.instragramSearchIcon,
      ],
      caption: 'You have got it, man',
      userModel: UserModel(
        userHandle: 'iam_prince',
        userId: '1',
        profileImage: Const.instragramAddIcon,
      ),
      likeModel: LikeModel(
        id: 'id1',
        likes: 100,
      ),
      commentModel: CommentModel(
        userHandle: '_goodMeagan_',
        userProfileImage: Const.userImage,
        dateTime: DateTime.now(),
      ),
    ),
  ];
}
