import 'package:get/get.dart';

class SavePostController extends GetxController {
  bool _isSaved = false;

  bool get isSaved => _isSaved;

  toggleSaveState() {
    _isSaved = !_isSaved;
    update();
  }
}
