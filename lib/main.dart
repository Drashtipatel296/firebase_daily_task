import 'package:chat/firebase_services/firebase_msg_services.dart';
import 'package:chat/firebase_services/google_sign_in_services.dart';
import 'package:chat/firebase_services/notification_services.dart';
import 'package:chat/view/home_screen.dart';
import 'package:chat/view/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationServices.notificationServices.initNotification();
  await FirebaseMsgServices.firebaseMsgServices.requestPermission();
  await FirebaseMsgServices.firebaseMsgServices.generateDeviceToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleSignInServices.googleSignInServices.currentUser() == null
          ? const RegisterPage()
          : const HomeScreen(),
    );
  }
}
