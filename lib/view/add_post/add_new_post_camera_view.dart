import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/theme/ui_layout_preference.dart';

import '../../controller/camera_controller/app_camera_controller.dart';
import '../../controller/post_controller/new_post_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cus_circular_progressbar.dart';
import '../camera/core/camera_close_button.dart';
import '../camera/core/camera_flash_light.dart';
import '../camera/core/camera_take_photo_or_video.dart';

class NewPostCameraView extends StatefulWidget {
  const NewPostCameraView({super.key});

  @override
  State<NewPostCameraView> createState() => _NewPostCameraViewState();
}

class _NewPostCameraViewState extends State<NewPostCameraView>
    with WidgetsBindingObserver {
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
                              const CameraFlashLight(height: 0.03),
                              const CameraCloseButton(height: 0.03),
                              TakePhotoOrVideo(
                                onTap: () async {
                                  if (!controller.isRecording) {
                                    XFile imageFile =
                                        await controller.takePhoto();
                                    NewPostController.instance
                                        .getImageAndPreview(imageFile.path);
                                  }
                                },
                                onLongPressUp: () async {
                                  XFile videoFile =
                                      await controller.stopAndSaveVideo();
                                  NewPostController.instance
                                      .getVideoAndPreview(videoFile.path);
                                },
                                onLongPressed: () async {
                                  await controller.recordVideo();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // gallery image
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        bottom: 10,
                        top: 10,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          await NewPostController.instance
                              .pickMediaFromDevice();
                        },
                        icon: const Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),

                    // switch camera view
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
