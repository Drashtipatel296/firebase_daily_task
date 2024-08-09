import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Screen'),
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: ElevatedButton(onPressed: () {
            Get.back();
          }, child: const Text('back'))
      ),
    );
  }
}