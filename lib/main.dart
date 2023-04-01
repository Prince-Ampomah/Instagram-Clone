import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app_state.dart';
import 'core/services/hive_helper_function.dart';
import 'core/theme/theme.dart';
import 'firebase_options.dart';
import 'view/authentication/sign_in_view/sign_in_view.dart';
import 'view/layout/app_layout.dart';

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
