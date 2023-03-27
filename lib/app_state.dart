import 'package:get/get.dart';
import 'package:instagram_clone/controller/models_controller/models_controller.dart';
import 'core/constants/constants.dart';
import 'core/services/hive_services.dart';
import 'model/user_model/user_model.dart';

import 'controller/auth_controller/auth_controller.dart';
import 'controller/post_controller/new_post_controller.dart';

class AppState {
  static UserModel? user = HiveServices.getUserBox().get(Const.currentUser);

  static injectAllControllers() {
    Get.put(AuthController());
    Get.put(NewPostController());
    Get.put(ModelController());
  }
}
