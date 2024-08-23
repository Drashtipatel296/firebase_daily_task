import 'package:chat/controller/auth_controller.dart';
import 'package:chat/firebase_services/chat_services.dart';
import 'package:chat/firebase_services/google_sign_in_services.dart';
import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.name.value,style: TextStyle(color: Colors.black),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: ChatServices.chatServices.getData(
                    GoogleSignInServices.googleSignInServices
                        .currentUser()!
                        .email!,
                    controller.receiverEmail.value),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var queryData = snapshot.data!.docs;
                  List chats = queryData.map((e) => e.data()).toList();
                  List<ChatModel> chatList = [];

                  for(var chat in chats){
                    chatList.add(ChatModel.fromMap(chat));
                  }

                  return Container(
                    width: double.infinity,
                    // color: Colors.grey.shade100,
                    child: Column(
                      children: List.generate(
                        chatList.length,
                        (index) {
                          return Align(
                            alignment: (chatList[index].sender ==
                                    GoogleSignInServices.googleSignInServices
                                        .currentUser()!
                                        .email!)
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(chatList[index].msg!),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: controller.txtMsg,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      Map<String, dynamic> chat = {
                        'sender': GoogleSignInServices.googleSignInServices
                            .currentUser()!
                            .email,
                        'receiver': controller.receiverEmail.value,
                        'msg': controller.txtMsg.text,
                        'timestamp': DateTime.now(),
                      };
                      ChatServices.chatServices.insertData(
                          chat,
                          GoogleSignInServices.googleSignInServices
                              .currentUser()!
                              .email!,
                          controller.receiverEmail.value);
                      controller.txtMsg.clear();
                    },
                    icon: const Icon(Icons.send)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
