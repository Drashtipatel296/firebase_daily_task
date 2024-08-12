import 'package:chat/controller/auth_controller.dart';
import 'package:chat/view/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      drawer: Drawer(
        child: Column(
            children: [
              DrawerHeader(
                child: Obx(
                  () => CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(authController.url.value),
                  ),
                ),
              ),
              Obx(() => Text(authController.email.value)),
              Obx(() => Text(authController.name.value)),
            ],
          ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Screen'),
        actions: [
          IconButton(
              onPressed: () {
                authController.emailLogOut();
                Fluttertoast.showToast(
                  msg: "Logged out successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                Get.off(() => const LoginScreen());
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: const Center(
        child: Text('Welcome You are logged in !!'),
      ),
    );
  }
}

