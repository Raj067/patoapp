import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:patoapp/animations/permission.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class NotificationAll {
  BuildContext context;
  String description;
  int id;
  DateTime sheduleDate;
  NotificationAll({
    required this.context,
    required this.id,
    required this.description,
    required this.sheduleDate,
  });
  sheduleAll() async {
    var val = NotifyDueDate(context: context, sheduleDate: sheduleDate);
    val.initialize();
    var status = await Permission.notification.request();
    if (status.isGranted) {
      try {
        val.scheduledNotification(
            title: 'Payment Reminder', id: id, description: description);
      } catch (e) {
        // For setting past time
      }
    } else {
      // ignore: use_build_context_synchronously
      permissionDenied(context);
    }
  }
}

class NotifyDueDate {
  BuildContext context;
  DateTime sheduleDate;
  NotifyDueDate({
    required this.context,
    required this.sheduleDate,
  });

  FlutterLocalNotificationsPlugin? flutterNotificationPlugin;
  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hello Everyone"),
        content: Text(payload),
      ),
    );
  }

  void initialize() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/launcher_icon');

    var initializationSettingsIOS = const IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

    flutterNotificationPlugin!.initialize(initializationSettings,
        onSelectNotification: (val) => onSelectNotification);
  }

  // Future notificationDefaultSound({
  //   required int id,
  //   required String title,
  //   required String description,
  // }) async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     "$id",
  //     'Shedule',
  //     channelDescription: 'Description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );

  //   var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

  //   var platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);

  //   flutterNotificationPlugin?.show(
  //       id, title, description, platformChannelSpecifics,
  //       payload: 'Default Sound');
  // }

  Future<void> scheduledNotification({
    required int id,
    required String title,
    required String description,
  }) async {
    DateTime recent = sheduleDate;
    // tz.;
    final scheduledDate = tz.TZDateTime(
        tz.getLocation('Africa/Nairobi'),
        recent.year,
        recent.month,
        recent.day,
        recent.hour,
        recent.minute,
        recent.second + 5);
    await flutterNotificationPlugin?.zonedSchedule(
      id,
      title,
      description,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily notification channel id',
          'daily notification channel name',
          channelDescription: 'daily notification description',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
