import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  static NotificationServices notificationServices = NotificationServices._();

  NotificationServices._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings darwinInitializationSettings = const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(int id, String title, String body) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
            'your_channel_id',
            'Message',
            channelDescription: 'your_channel_description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
            ticker: 'ticker',
        );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        platformChannelSpecifics);
  }

  // void showScheduleNotification() {
  //   AndroidNotificationDetails androidNotificationDetails =
  //       const AndroidNotificationDetails('chat', 'Chat App',
  //           importance: Importance.max, priority: Priority.high);
  //
  //   NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );
  //   flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       "Schedule Notification",
  //       "A chat app with firebase integration - authentication",
  //       tz.TZDateTime.now(tz.getLocation('Asia/kolkata')).add(const Duration(seconds: 5)),
  //       notificationDetails,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }
}
