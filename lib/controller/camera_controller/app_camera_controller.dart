import 'dart:math';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/view/messages/core/chat_preview_video.dart';

import '../../core/widgets/cus_video_player.dart';
import '../../view/messages/core/chat_preview_image.dart';
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

  Future<void> recordVideo() async {
    await AppCameraController.instance.cameraController.startVideoRecording();
    isRecording = true;
    update();
  }

  Future<XFile> takePhoto() async {
    isCameraCaptured = true;
    update();

    XFile file =
        await AppCameraController.instance.cameraController.takePicture();

    // ChatController.instance.chatMedia!.clear();
    // ChatController.instance.chatMedia = [file.path];

    // // send user to image view page when user tap on the
    // // Get.to(
    // //   () => const ChatImagePreview(isFromGallery: false),
    // // );

    isCameraCaptured = false;
    update();

    return file;
  }

  Future<XFile> stopAndSaveVideo() async {
    // Get the video File form the controller
    XFile videoFile = await AppCameraController.instance.cameraController
        .stopVideoRecording();

    // Update the state of the widget
    isRecording = false;
    update();

    // ChatController.instance.chatMedia!.clear();
    // ChatController.instance.chatMedia = [videoFile.path];
    // send user to video player page when user is done recording
    // Get.to(
    //   () => ChatPreviewVideo(
    //     videoPath: ChatController.instance.chatMedia!.first,
    //     showSendButton: true,
    //   ),
    // );

    return videoFile;
  }

  @override
  void dispose() {
    cameraController.dispose();

    super.dispose();
  }
}
