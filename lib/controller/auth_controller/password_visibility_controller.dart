import 'package:get/get.dart';

class PasswordVisibilityController extends GetxController {
  bool showPassword = true;

  togglePassword() {
    showPassword = !showPassword;
    update();
  }
}
