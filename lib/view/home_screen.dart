import 'package:chat/controller/auth_controller.dart';
import 'package:chat/view/signup_screen.dart';
import 'package:flutter/material.dart';
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
                  backgroundImage: NetworkImage(authController.url.value ??
                      'https://img.freepik.com/free-photo/young-smiling-businesswoman_329181-11700.jpg'),
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
                Get.to(const RegisterPage());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text('Welcome You are logged in !!'),
      ),
    );
  }
}
