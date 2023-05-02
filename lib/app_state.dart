import 'package:get/get.dart';
import 'package:instagram_clone/controller/camera_controller/app_camera_controller.dart';
import 'package:instagram_clone/controller/chat_controller/chat_controller.dart';
import 'package:instagram_clone/controller/follow_controller/follow_controller.dart';
import 'package:instagram_clone/controller/notification_controller/notification_controller.dart';
import 'package:instagram_clone/controller/post_controller/comment_controller.dart';
import 'package:instagram_clone/controller/story_controller/story_controller.dart';

import 'controller/auth_controller/auth_controller.dart';
import 'controller/models_controller/models_controller.dart';
import 'controller/post_controller/like_controller.dart';
import 'controller/post_controller/post_controller.dart';
import 'controller/post_controller/save_controller.dart';
import 'controller/profile_controller/edit_profile_controller.dart';
import 'core/constants/constants.dart';
import 'core/services/hive_services.dart';
import 'model/user_model/user_model.dart';

class AppState {
  static UserModel? user = HiveServices.getUserBox().get(Const.currentUser);

  static injectControllers() {
    Get.put(AuthController());
    Get.put(PostController());
    Get.put(LikeController());
    Get.put(CommentController());
    Get.put(EditProfileController());
    Get.put(SavePostController());
    Get.put(ModelController());
    Get.put(FollowController());
    Get.put(NotificationController());
    Get.put(ChatController());
    Get.put(AppCameraController());
    Get.put(StoryController());
    // Get.put(AudioRecorderController());
  }
}
