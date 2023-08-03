import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/camera_controller/app_camera_controller.dart';

class CameraFlashLight extends StatelessWidget {
  const CameraFlashLight({
    super.key,
    this.height = 0.06,
  });

  final double? height;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * height!,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: GetBuilder<AppCameraController>(
          builder: (controller) {
            return IconButton(
              onPressed: controller.toggleFlashLightMode,
              icon: Icon(
                controller.flash ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
                size: 30,
              ),
            );
          },
        ),
      ),
    );
  }
}
