import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/camera_controller/app_camera_controller.dart';

class CameraFlashLight extends StatefulWidget {
  const CameraFlashLight({
    super.key,
  });

  @override
  State<CameraFlashLight> createState() => _CameraFlashLightState();
}

class _CameraFlashLightState extends State<CameraFlashLight> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.06,
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
