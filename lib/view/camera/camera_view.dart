import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/camera_controller/app_camera_controller.dart';
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GetBuilder<AppCameraController>(
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
                              children: const [
                                UserToMessage(),
                                CameraFlashLight(),
                                CameraCloseButton(),
                                TakePhotoOrVideo(),
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
          )),
    );
  }

/**
 *   void _takeVideo(BuildContext context) async {
    // Get the video File form the controller
    XFile video = await AppCameraController.instance.cameraController
        .stopVideoRecording();

    // Update the state of the widget
    setState(() => isRecording = false);

    // Navigator.pop(context);

    // send user to video player page when user is done recording
    if (!mounted) {
      return;
    }
    // sendToPage(
    //   context,
    //   MessageBoxVideoPlayer(
    //     videoFile: video.path,
    //     onVideoAccepted: widget.onVideoTaken,
    //   ),
    // );
  }

  void takePhoto(BuildContext context) async {
    setState(() => isCameraCaptured = true);
    XFile file =
        await AppCameraController.instance.cameraController.takePicture();

    ChatController.instance.chatMedia!.clear();
    ChatController.instance.chatMedia = [file.path];

    // send user to image view page when user tap on the
    if (!mounted) {
      return;
    }
    sendToPage(context, const ChatImagePreview());
    setState(() => isCameraCaptured = false);
  }
 */
}


/**
 * 
                          Positioned(
                            bottom: size.height * 0.09,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (!isCameraCaptured)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onLongPress: () async {
                                          await cameraController
                                              .startVideoRecording();
                                          setState(() => isRecording = true);
                                        },
                                        onLongPressUp: () {
                                          _takeVideo(context);
                                        },
                                        onTap: () {
                                          if (!isRecording) {
                                            takePhoto(context);
                                          }
                                        },
                                        child: isRecording
                                            ? const Icon(
                                                Icons.radio_button_on,
                                                color: Colors.red,
                                                size: 80,
                                              )
                                            : const Icon(
                                                Icons.panorama_fish_eye,
                                                color: Colors.white,
                                                size: 70,
                                              ),
                                      ),
                                    ],
                                  ),

                              ],
                            ),
                          ),
 */