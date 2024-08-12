import 'package:chat/controller/auth_controller.dart';
import 'package:chat/firebase_services/google_sign_in_services.dart';
import 'package:chat/view/auth_screen.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleSignInServices.googleSignInServices.currentUser() == null
          ? const RegisterPage()
          : const HomeScreen(),
    );
  }
}
