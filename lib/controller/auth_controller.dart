import 'dart:io';

import 'package:chat/firebase_services/chat_services.dart';
import 'package:chat/firebase_services/media_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../firebase_services/auth_services.dart';
import '../firebase_services/google_sign_in_services.dart';
import '../view/home_screen.dart';

class AuthController extends GetxController {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtMsg = TextEditingController();
  TextEditingController txtEditMsg = TextEditingController();

  RxString email = ''.obs;
  RxString name = ''.obs;
  RxString url = ''.obs;
  RxString receiverEmail = "".obs;
  RxString receiverName = "".obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  void getReceiver(String email, String name) {
    receiverEmail.value = email;
    receiverName.value = name;
  }

  void getUserDetails() {
    User? user = GoogleSignInServices.googleSignInServices.currentUser();
    if (user != null) {
      email.value = user.email!;
      name.value = user.displayName!;
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      bool emails = await AuthServices.authServices.checkEmail(email);
      if (emails) {
        Get.snackbar(
          'Sign Up Failed',
          'Email already in use. Please use a different email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        await AuthServices.authServices.createAccount(email, password);
        Get.snackbar(
          'Sign Up',
          'Sign Up Successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Sign Up Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      User? user = await AuthServices.authServices.Signin(email, password);
      if (user != null) {
        Get.to(const HomeScreen());
      } else {
        Get.snackbar(
          'Login Failed',
          'Incorrect email or password.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void emailLogOut() {
    AuthServices.authServices.signout();
    GoogleSignInServices.googleSignInServices.emailLogOut();
  }

  Future<void> sendMediaFile(File file) async {
    String? downloadUrl =
        await StorageServices.storageServices.uploadMediaFile(file);
    if (downloadUrl != null) {
      Map<String, dynamic> chat = {
        'sender': GoogleSignInServices.googleSignInServices.currentUser()!.email,
        'receiver': receiverEmail.value,
        'msg': 'Sent an image',
        'mediaUrl': downloadUrl,
        'timestamp': DateTime.now(),
      };
      ChatServices.chatServices.insertData(
          chat,
          GoogleSignInServices.googleSignInServices.currentUser()!.email!,
          receiverEmail.value);
    }else{
      Get.snackbar(
        'Upload Failed',
        'Failed to upload the image. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
