import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMsgServices{
  FirebaseMsgServices._();
  static FirebaseMsgServices firebaseMsgServices = FirebaseMsgServices._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    NotificationSettings notificationSettings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(notificationSettings.authorizationStatus == AuthorizationStatus.authorized){
      log('Notification Permission Allowed !!');
    }
    else if(notificationSettings.authorizationStatus == AuthorizationStatus.denied){
      log('Notification Permission Denied');
    }
  }

  Future<void> generateDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    log('Device Token: $token');
  }
}