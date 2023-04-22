import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/widgets/cust_video_player.dart';

import '../../view/messages/chat_room/chat_preview_image.dart';
import '../chat_controller/chat_controller.dart';

late List<CameraDescription> cameras;

class AppCameraController extends GetxController {
  static AppCameraController instance = Get.find<AppCameraController>();

  late CameraController cameraController;
  Future<void>? cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;
  bool isCameraCaptured = false;

  getAvailbleCameras() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = cameraController.initialize();
    update();
  }

  void flipCameraView() {
    iscamerafront = !iscamerafront;
    transform = transform + pi;

    update();

    int cameraPos = iscamerafront ? 0 : 1;
    AppCameraController.instance.cameraController = CameraController(
      cameras[cameraPos],
      ResolutionPreset.high,
    );
    AppCameraController.instance.cameraValue =
        AppCameraController.instance.cameraController.initialize();
  }

  void toggleFlashLightMode() {
    flash = !flash;
    update();

    flash
        ? AppCameraController.instance.cameraController
            .setFlashMode(FlashMode.torch)
        : AppCameraController.instance.cameraController
            .setFlashMode(FlashMode.off);
  }

  recordVideo() async {
    await AppCameraController.instance.cameraController.startVideoRecording();
    isRecording = true;
    update();
  }

  void takePhoto() async {
    isCameraCaptured = true;
    update();

    XFile file =
        await AppCameraController.instance.cameraController.takePicture();

    ChatController.instance.chatMedia!.clear();
    ChatController.instance.chatMedia = [file.path];

    // send user to image view page when user tap on the
    Get.to(() => const ChatImagePreview(
          isFromGallery: false,
        ));

    isCameraCaptured = false;
    update();
  }

  void stopAndSaveVideo() async {
    // Get the video File form the controller
    XFile video = await AppCameraController.instance.cameraController
        .stopVideoRecording();

    // Update the state of the widget
    isRecording = false;
    update();

    // send user to video player page when user is done recording
    Get.to(() => CusVideoPlayer(videoPath: video.path));
  }

  @override
  void dispose() {
    cameraController.dispose();

    super.dispose();
  }
}
