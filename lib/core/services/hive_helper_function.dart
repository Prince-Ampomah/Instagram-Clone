import 'package:hive_flutter/hive_flutter.dart';

import '../../model/user_model/user_model.dart';
import '../constants/constants.dart';

Future<void> initHiveServices() async {
  //init hive with [getApplicationDocumentsDirectory]
  await Hive.initFlutter();

  // register hive adapter services
  Hive.registerAdapter(UserModelAdapter());

  // open hive boxes
  await Hive.openBox<UserModel>(Const.userBoxName);
}
