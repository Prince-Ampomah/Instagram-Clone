import 'package:hive_flutter/hive_flutter.dart';
import 'package:instagram_clone/model/post_model/post_location_model.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';

import '../../model/user_model/user_model.dart';
import '../constants/constants.dart';

Future<void> initHiveServices() async {
  //init hive with [getApplicationDocumentsDirectory]
  await Hive.initFlutter();

  // register hive adapter services
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(PostLocationModelAdapter());

  // open hive boxes
  await Hive.openBox<UserModel>(Const.userBoxName);
  await Hive.openBox<PostModel>(Const.postBoxName);
  await Hive.openBox(Const.postIdName);
}
