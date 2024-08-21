import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? sender, receiver, msg;
  Timestamp? timestamp;

  ChatModel({
    required this.sender,
    required this.receiver,
    required this.msg,
    required this.timestamp,
  });

  factory ChatModel.fromMap(Map m1) {
    return ChatModel(
        sender: m1['sender'],
        receiver: m1['receiver'],
        msg: m1['msg'],
        timestamp: m1['timestamp']);
  }

  Map<String, dynamic> toMap(ChatModel chat){
    return {
      'sender' : chat.sender,
      'receiver' : chat.receiver,
      'msg' : chat.msg,
      'timestamp' : chat.timestamp,
    };
  }
}
