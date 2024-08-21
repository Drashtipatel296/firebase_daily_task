import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices{
  static ChatServices chatServices = ChatServices._();
  ChatServices._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> insertData(Map<String, dynamic> chat) async {
    await firestore.collection("chatroom").add(chat);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getData(){
    return firestore.collection("chatroom").snapshots();
  }
}