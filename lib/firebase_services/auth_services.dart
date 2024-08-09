import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static AuthServices authServices = AuthServices();

  Future<void> createAccount(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    print(userCredential.user!.email);
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> checkEmail(String email) async {
    try {
      List<String> signInMethod = await firebaseAuth.fetchSignInMethodsForEmail(email);
      return signInMethod.isNotEmpty;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> signOutMethod() async {
    await firebaseAuth.signOut();
    User? user = firebaseAuth.currentUser;
    if (user == null) {
      Get.back();
    }
  }
}
