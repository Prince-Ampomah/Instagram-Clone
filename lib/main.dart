import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/view/authentication/sign_up_view/sign_up_name_and_password_view.dart';

import 'core/theme/theme.dart';
import 'firebase_options.dart';
import 'view/authentication/sign_in_view/sign_in_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.whiteColor,
    // statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: const SignInView(),

      // PageView(
      //   reverse: false,
      //   children: [
      //     AppLayoutView(),
      //     const Messages(),
      //     const Camera(),
      //   ],
      // ),
    );
  }
}
