import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  static ChatServices chatServices = ChatServices._();

  ChatServices._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> insertData(
      Map<String, dynamic> chat, String sender, String receiver) async {
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("-");
    await firestore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .add(chat);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getData(
      String sender, String receiver) {
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("-");
    return firestore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> editMsg({required String sender, required String receiver, required String chatId, required String msg}) async {
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("-");
    await FirebaseFirestore.instance.collection("chatroom").doc(docId).collection("chat").doc(chatId).update({
      'msg' : msg,
    });
  }

  Future<void> deleteMsg({required String sender, required String receiver, required String chatId}) async {
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("-");
    await FirebaseFirestore.instance.collection("chatroom").doc(docId).collection("chat").doc(chatId).delete();
  }
}
