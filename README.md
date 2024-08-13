# Firebase Daily Tasks

# Sign In & Sign Up with Email & Password with Google Authentication

Certainly! Here's a concise breakdown of how to implement the login and sign-up app using GetX state management and Google email ID sign-in, without including the full screen code:

### **1. Project Setup**
- **Add Dependencies**:
  In your `pubspec.yaml`, include the necessary dependencies:
  ```yaml
  dependencies:
    flutter:
      sdk: flutter
    firebase_core: latest_version
    firebase_auth: latest_version
    google_sign_in: latest_version
    get: latest_version
  ```

- **Initialize Firebase**:
  In your `main.dart`, initialize Firebase before running the app:
  ```dart
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
  }
  ```

### **2. Authentication Logic with GetX**

- **Create an Authentication Controller**:
  Manage authentication logic and state using GetX by creating a `auth_controller.dart`:
  ```dart
  class AuthController extends GetxController {
    FirebaseAuth auth = FirebaseAuth.instance;
    var isSignedIn = false.obs;
    Rx<User?> firebaseUser = Rx<User?>(null);

    @override
    void onInit() {
      super.onInit();
      firebaseUser.bindStream(auth.authStateChanges());
      ever(firebaseUser, _setInitialScreen);
    }

    _setInitialScreen(User? user) {
      if (user == null) {
        Get.offAll(() => LoginScreen());
      } else {
        Get.offAll(() => HomeScreen());
      }
    }

    void register(String email, String password) async {
      try {
        await auth.createUserWithEmailAndPassword(email: email, password: password);
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }

    void login(String email, String password) async {
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }

    void googleSignIn() async {
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await auth.signInWithCredential(credential);
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }

    void signOut() async {
      await auth.signOut();
    }
  }
  ```

### **3. App Routing with GetX**

- **Set Up Routing**:
  Define routes in `main.dart` using GetX’s `GetMaterialApp`:
  ```dart
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return GetMaterialApp(
        initialRoute: '/login',
        getPages: [
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/signup', page: () => SignUpScreen()),
          GetPage(name: '/home', page: () => HomeScreen()),
        ],
      );
    }
  }
  ```

This structure outlines the core components and flow without delving into specific UI implementations, focusing instead on the underlying logic and setup. If you need more details on any specific part, let me know!

### ScreenShorts

<p align='center'>
  <img src='https://github.com/user-attachments/assets/13f46404-4351-4595-97c2-5c995a9c9302' width=240>
  <img src='https://github.com/user-attachments/assets/2ef51dc9-aba0-4d35-bd78-3ed2c24073f4' width=240>
  <img src='https://github.com/user-attachments/assets/e2efc0c2-b93c-47ac-a6ff-9127eeb86dd9' width=240>
</p>

### Video
https://github.com/user-attachments/assets/e0d985de-236c-4d52-8a7d-ff1ffa8a43db


![Screenshot 2024-08-08 144809](https://github.com/user-attachments/assets/266a3880-dc6f-4d08-9c90-2908db6339a5)


# Add & Read User in Cloud Firestore

### **Add User Data**

- **To add user data to Firestore, use the following code:**:
   ```dart
  import 'package:cloud_firestore/cloud_firestore.dart';

  Future<void> addUser(String userId, String name, String email) async {
  // Get a reference to the Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Add user data to Firestore
  await firestore.collection('users').doc(userId).set({
    'name': name,
    'email': email,
    });
  }
  ```

### **Read User Data**

- **To read user data from Firestore, use the following code:**:
   ```dart
   import 'package:cloud_firestore/cloud_firestore.dart';

  Future<void> getUser(String userId) async {
  // Get a reference to the Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Retrieve user data from Firestore
  DocumentSnapshot userDoc = await firestore.collection('users').doc(userId).get();

  if (userDoc.exists) {
    print('User Data: ${userDoc.data()}');
  } else {
    print('No user found with the provided ID.');
    }
  }
    ```

### **Example Usage**

- **Here’s how you might use the above functions in a Flutter widget:**:
   ```dart
    import 'package:flutter/material.dart';

  class HomeScreen extends StatelessWidget {
  final String userId = 'user123';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                addUser(userId, 'John Doe', 'john.doe@example.com');
              },
              child: Text('Add User'),
            ),
            ElevatedButton(
              onPressed: () {
                getUser(userId);
              },
              child: Text('Get User'),
            ),
          ],
        ),
      ),
    );
   }
  }
  ```

### Video

https://github.com/user-attachments/assets/a0aae946-9624-4b7e-a025-ef5237ee1ed1























