import 'package:get/get.dart';

class AppLayoutController extends GetxController {
  int pageIndex = 0;

  changePageIndex(int index) {
    pageIndex = index;

    update();
  }
}
