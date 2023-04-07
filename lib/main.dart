import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import 'app_state.dart';
import 'core/services/hive_helper_function.dart';
import 'core/theme/theme.dart';
import 'core/theme/ui_layout_preference.dart';
import 'firebase_options.dart';
import 'view/authentication/sign_in_view/sign_in_view.dart';
import 'view/layout/app_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  UIPreferenceLayout.setPreferences();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // set up hive services before inject controller since hive service is initialize in the auth controller
  await initHiveServices();

  AppState.injectControllers();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: AppTheme.lightTheme(context),
        home: AppState.user?.userId != null
            ? AppLayoutView()
            : const SignInView(),
      ),
    );
  }
}
