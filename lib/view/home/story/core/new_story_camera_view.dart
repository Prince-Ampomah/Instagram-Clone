import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/camera_controller/app_camera_controller.dart';
import 'package:instagram_clone/controller/story_controller/story_controller.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/cus_circular_progressbar.dart';
import '../../../camera/core/camera_close_button.dart';
import '../../../camera/core/camera_flash_light.dart';
import '../../../camera/core/camera_take_photo_or_video.dart';

class NewStoryPostCameraView extends StatefulWidget {
  const NewStoryPostCameraView({super.key});

  @override
  State<NewStoryPostCameraView> createState() => _NewStoryPostCameraViewState();
}

class _NewStoryPostCameraViewState extends State<NewStoryPostCameraView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AppCameraController.instance.getAvailbleCameras();
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
        AppCameraController.instance.cameraController.dispose();
        !AppCameraController.instance.cameraController.value.isInitialized;
        false;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.blackColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
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
                                    StoryController.instance
                                        .getImageAndPreview(imageFile.path);
                                  }
                                },
                                onLongPressUp: () async {
                                  XFile videoFile =
                                      await controller.stopAndSaveVideo();
                                  StoryController.instance
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
                          await StoryController.instance.pickMediaFromDevice();
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
