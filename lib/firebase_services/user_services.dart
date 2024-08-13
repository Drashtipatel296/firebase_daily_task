import 'package:chat/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices{
  static UserServices userServices = UserServices._();
  UserServices._();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) async {
    final CollectionReference collectionReference = firebaseFirestore.collection("users");
    await collectionReference.doc(user.email).set(user.toMap(user));
  }

  Stream<QuerySnapshot<Object?>> getUser(){
    CollectionReference collectionReference = firebaseFirestore.collection("users");
    return collectionReference.snapshots();
  }

  DocumentReference<Object?> getCurrentUser(User user){
    final CollectionReference collectionReference = firebaseFirestore.collection("users");
    return collectionReference.doc(user.email);
  }
}