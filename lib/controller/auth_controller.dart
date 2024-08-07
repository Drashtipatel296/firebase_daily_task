import 'package:chat/firebase_services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  void logIn(String email, String password){
    AuthServices.authServices.createAccount(email, password);
  }
}