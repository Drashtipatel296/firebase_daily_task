import 'package:chat/controller/auth_controller.dart';
import 'package:chat/firebase_services/auth_services.dart';
import 'package:chat/firebase_services/user_services.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/view/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../firebase_services/google_sign_in_services.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var controller = Get.put(AuthController());

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/login.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 40, top: 180),
                child: const Text(
                  'Welcome\nBack',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 460, left: 35, right: 35),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        labelText: 'Email',
                        hintText: 'Email',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: controller.txtEmail,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        labelText: 'Password',
                        hintText: 'Password',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: controller.txtPassword,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 205),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              color: Color(0xff4c505b)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    SignInButton(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        Buttons.google, onPressed: () async {
                      String status = await GoogleSignInServices.googleSignInServices.signWithGoogle();

                          User? user = GoogleSignInServices.googleSignInServices.currentUser();
                          Map m1 = {
                            'name' : user!.displayName,
                            'email' : user.email,
                            'photoUrl' : user.photoURL,
                          };
                          UserModel userModel = UserModel.fromMap(m1);
                          await UserServices.userServices.addUser(userModel);

                      Fluttertoast.showToast(msg: status);
                      if (status == 'Success') {
                        Get.to(const HomeScreen());
                      }

                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.signIn(controller.txtEmail.text, controller.txtPassword.text);
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xff3A434D),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.txtEmail.clear();
                            controller.txtPassword.clear();
                            Get.to(const RegisterPage());
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Color(0xff4c505b)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
