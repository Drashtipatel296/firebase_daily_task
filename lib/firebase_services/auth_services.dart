import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static AuthServices authServices = AuthServices();

  Future<void> createAccount(String email, String password) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    print(userCredential.user!.email);
  }

  Future<User?> Signin(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> checkEmail(String email) async {
    try {
      List<String> signIn = await auth.fetchSignInMethodsForEmail(email);
      return signIn.isNotEmpty;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> signout() async {
    await auth.signOut();
    User? user = auth.currentUser;
    if (user == null) {
      Get.back();
    }
  }
}