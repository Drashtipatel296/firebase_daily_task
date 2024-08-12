import 'dart:developer';
import 'package:chat/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInServices{
  static GoogleSignInServices googleSignInServices = GoogleSignInServices._();
  GoogleSignInServices._();


  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signWithGoogle() async {
    try{
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      await firebaseAuth.signInWithCredential(authCredential);
      return "Success";
    }catch(e){
      log(e.toString());
      return "Failed";
    }
  }

  void emailLogOut() async {
    googleSignIn.signOut();
    firebaseAuth.signOut();
  }

  User? currentUser(){
    User? user = firebaseAuth.currentUser;
    // if(user != null){
    //   print(user.email);
    //   print(user.displayName);
    //   print(user.phoneNumber);
    //   print(user.photoURL);
    // }
    return user;
  }
}