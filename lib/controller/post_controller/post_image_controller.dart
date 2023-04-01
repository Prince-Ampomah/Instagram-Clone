import 'package:get/get.dart';

class PostImageController extends GetxController {
  int countImage = 1;

  onPageChanged(int i) {
    countImage = i + 1;
    update();
  }
}
