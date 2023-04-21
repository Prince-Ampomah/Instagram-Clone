import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:instagram_clone/controller/chat_controller/chat_controller.dart';
import 'package:instagram_clone/core/utils/utils.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';
import 'package:instagram_clone/view/messages/chat_room/chat_preview_image.dart';

import '../../core/utils/helper_functions.dart';

late List<CameraDescription> _cameras;

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _cameraController;
  Future<void>? cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;
  bool isCameraCaptured = false;

  @override
  void initState() {
    super.initState();
    _getAvailbleCameras();
  }

  _getAvailbleCameras() async {
    _cameras = await availableCameras();
    setState(() {
      _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
      cameraValue = _cameraController.initialize();
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return const Center(
                  child: CustomCircularProgressBar(),
                );
              }
            },
          ),

          // control buttons [take photo, rotate camera, flash light] widget
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(bottom: 15),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isCameraCaptured)
                    const Center(
                      child: Text(
                        'Hold Still\nCapturing image...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (!isCameraCaptured)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() => flash = !flash);
                            flash
                                ? _cameraController
                                    .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          },
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        GestureDetector(
                          onLongPress: () async {
                            await _cameraController.startVideoRecording();
                            setState(() => isRecording = true);
                          },
                          onLongPressUp: () {
                            _takeVideo(context);
                          },
                          onTap: () {
                            if (!isRecording) takePhoto(context);
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
                        IconButton(
                            icon: Transform.rotate(
                              angle: transform,
                              child: const Icon(
                                Icons.flip_camera_ios,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                iscamerafront = !iscamerafront;
                                transform = transform + pi;
                              });
                              int cameraPos = iscamerafront ? 0 : 1;
                              _cameraController = CameraController(
                                _cameras[cameraPos],
                                ResolutionPreset.high,
                              );
                              cameraValue = _cameraController.initialize();
                            }),
                      ],
                    ),
                  const SizedBox(height: 10),
                  if (!isCameraCaptured)
                    const Text(
                      "Hold for Video or Tap for photo",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _takeVideo(BuildContext context) async {
    // Get the video File form the controller
    XFile video = await _cameraController.stopVideoRecording();

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
    setState(() {
      isCameraCaptured = true;
    });
    XFile file = await _cameraController.takePicture();

    setState(() {
      ChatController.instance.chatMedia = [file.path];
    });
    // send user to image view page when user tap on the
    if (!mounted) {
      return;
    }
    sendToPage(context, const ChatImagePreview());
    setState(() {
      isCameraCaptured = false;
    });
  }
}
