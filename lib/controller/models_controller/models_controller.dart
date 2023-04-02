import 'package:get/get.dart';
import 'package:instagram_clone/model/post_model/comment_model.dart';
import 'package:instagram_clone/model/post_model/like_model.dart';
import 'package:instagram_clone/model/post_model/post_location_model.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';

class ModelController extends GetxController {
  static ModelController instance = Get.find<ModelController>();

  UserModel userModel = UserModel();
  PostModel postModel = PostModel();
  CommentModel commentModel = CommentModel();
  LikeModel likeModel = LikeModel();
  PostLocationModel postLocationModel = PostLocationModel();
}
