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
        title: const Text('Chat Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: ChatServices.chatServices.getData(),
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),);
                  }

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }

                  var queryData = snapshot.data!.docs;
                  List chats = queryData.map((e) => e.data(),).toList();
                  List<ChatModel> chatList = chats.map((e) => ChatModel.fromMap(e)).toList();

                  return ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                    return Text(chatList[index].msg!);
                  },);
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
                suffixIcon: IconButton(onPressed: () {
                  Map<String, dynamic> chat = {
                    'sender' : GoogleSignInServices.googleSignInServices.currentUser()!.email,
                    'receiver' : controller.receiverEmail.value,
                    'msg' : controller.txtMsg.text,
                    'timestamp' : DateTime.now(),
                  };
                  controller.txtMsg.clear();
                  ChatServices.chatServices.insertData(chat);
                }, icon: const Icon(Icons.send)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
