import 'package:hive/hive.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';

import '../constants/constants.dart';
import '../../model/user_model/user_model.dart';

class HiveServices {
  static Box<UserModel> getUserBox() => Hive.box<UserModel>(Const.userBoxName);
  static Box<PostModel> getPosts() => Hive.box<PostModel>(Const.postBoxName);

  static Future<void> savePostId(String postId) async {
    return await Hive.box(Const.postIdName).put('postId', postId);
  }

  static dynamic getPostId() {
    return Hive.box(Const.postIdName).get('postId');
  }
}
