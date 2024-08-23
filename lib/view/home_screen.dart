import 'package:chat/controller/auth_controller.dart';
import 'package:chat/firebase_services/google_sign_in_services.dart';
import 'package:chat/firebase_services/user_services.dart';
import 'package:chat/view/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
            future: UserServices.userServices.getCurrentUser(
                GoogleSignInServices.googleSignInServices.currentUser()!),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }

              if(snapshot.connectionState == ConnectionState.waiting){
                return const Text('Loading ....');
              }

              Map<String, dynamic> currentUser = snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: CircleAvatar(radius: 70,backgroundImage: NetworkImage(currentUser['photoUrl']),),
                  ),
                  const SizedBox(height: 20,),
                  Text(currentUser['name'],style: const TextStyle(fontWeight: FontWeight.bold),),
                  Text(currentUser['email']),
                  Text(currentUser['phone']),
                ],
              );
            },),
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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: UserServices.userServices.getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  List userList = snapshot.data!.docs
                      .map(
                        (e) => e.data(),
                      )
                      .toList();
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      var user = userList[index];
                      return GestureDetector(
                        onTap: () {
                          authController.getReceiver(userList[index]['email']);
                          Get.to(const ChatScreen());
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user['photoUrl']),
                          ),
                          title: Text(user['name']),
                          subtitle: Text(user['email']),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No users found.'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
