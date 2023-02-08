import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/view/camera/camera.dart';
import 'package:instagram_clone/view/messages/messages.dart';
import 'core/theme/theme.dart';
import 'firebase_options.dart';

import 'view/layout/app_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: PageView(
        reverse: false,
        children: [
          AppLayoutView(),
          const Messages(),
          const Camera(),
        ],
      ),
    );
  }
}
