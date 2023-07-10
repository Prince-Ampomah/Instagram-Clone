import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/camera_controller/app_camera_controller.dart';

class TakePhotoOrVideo extends StatelessWidget {
  const TakePhotoOrVideo({
    super.key,
    required this.onLongPressed,
    required this.onLongPressUp,
    required this.onTap,
  });

  final VoidCallback onLongPressed;
  final VoidCallback onLongPressUp;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: size.height * 0.04,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GetBuilder<AppCameraController>(
          builder: (controller) {
            return GestureDetector(
              onTap: onTap,
              onLongPress: onLongPressed,
              onLongPressUp: onLongPressUp,
              child: controller.isRecording
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
            );
          },
        ),
      ),
    );
  }
}
