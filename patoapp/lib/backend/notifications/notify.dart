// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// displayNotification({required String title, required String body}) async {
//   print("doing test");
//   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//       'your channel id', 'your channel name',
//       importance: Importance.max, priority: Priority.high);
//   var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
//   var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'You change your theme',
//     'You changed your theme back !',
//     platformChannelSpecifics,
//     payload: 'It could be anything you pass',
//   );
// }
