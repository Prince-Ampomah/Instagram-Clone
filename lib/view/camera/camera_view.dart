import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/camera_controller/app_camera_controller.dart';
import '../../controller/chat_controller/chat_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/ui_layout_preference.dart';
import '../../core/widgets/cus_circular_progressbar.dart';
import 'core/camera_close_button.dart';
import 'core/camera_flash_light.dart';
import 'core/camera_take_photo_or_video.dart';
import 'core/user_to_message.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AppCameraController.instance.getAvailbleCameras();
    UIPreferenceLayout.setPreferences(
      statusBarColor: AppColors.blackColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        AppCameraController.instance.cameraController.dispose();
        !AppCameraController.instance.cameraController.value.isInitialized;
        break;
      case AppLifecycleState.resumed:
        AppCameraController.instance.getAvailbleCameras();
        break;
      case AppLifecycleState.paused:
        AppCameraController.instance.cameraController.dispose();
        !AppCameraController.instance.cameraController.value.isInitialized;
        break;
      case AppLifecycleState.detached:
        AppCameraController.instance.cameraController.dispose();
        !AppCameraController.instance.cameraController.value.isInitialized;
        break;

      default:
        false;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: GetBuilder<AppCameraController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: controller.cameraValue,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CameraPreview(
                            controller.cameraController,
                            child: Stack(
                              children: [
                                const UserToMessage(),
                                const CameraFlashLight(),
                                const CameraCloseButton(),
                                TakePhotoOrVideo(
                                  onTap: () async {
                                    if (!controller.isRecording) {
                                      XFile imageFile =
                                          await controller.takePhoto();

                                      // send user to photo preview
                                      ChatController.instance
                                          .getImageAndPreview(imageFile.path);
                                    }
                                  },
                                  onLongPressed: () async {
                                    await controller.recordVideo();
                                  },
                                  onLongPressUp: () async {
                                    XFile videoFile =
                                        await controller.stopAndSaveVideo();

                                    // send user to video preview
                                    ChatController.instance
                                        .getVideoAndPreview(videoFile.path);
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: CustomCircularProgressBar(),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: IconButton(
                      onPressed: controller.flipCameraView,
                      icon: const Icon(
                        Icons.flip_camera_android,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
