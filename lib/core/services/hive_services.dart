import 'package:hive/hive.dart';

import '../constants/constants.dart';
import '../../model/user_model/user_model.dart';

class HiveServices {
  static Box<UserModel> getUserBox() => Hive.box<UserModel>(Const.userBoxName);
}
