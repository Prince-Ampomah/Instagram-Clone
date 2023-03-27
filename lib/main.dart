import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app_state.dart';
import 'package:instagram_clone/controller/post_controller/new_post_controller.dart';
import 'package:instagram_clone/view/authentication/sign_in_view/sign_in_view.dart';
import 'package:instagram_clone/view/layout/app_layout.dart';

import 'controller/auth_controller/auth_controller.dart';
import 'controller/auth_controller/auth_listener.dart';
import 'core/services/hive_helper_function.dart';
import 'core/theme/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.whiteColor,
    // statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // set up hive services before inject controller since hive service is initialize in the auth controller
  await initHiveServices();

  AppState.injectAllControllers();

  // Get.put(AuthController());
  // Get.put(NewPostController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: AppTheme.lightTheme(context),
      home:
          AppState.user?.userId != null ? AppLayoutView() : const SignInView(),
    );
  }
}
