import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin? flutterNotificationPlugin;

class Notification {
  var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: IOSInitializationSettings());

  FlutterLocalNotificationsPlugin flutterNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  // flutterNotificationPlugin.initialize(initializationSettings,
  //     onSelectNotification: (val) => onSelectNotification);
  Notification();
}
