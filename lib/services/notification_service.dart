import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin __notification =
    FlutterLocalNotificationsPlugin();

class NotificationService {
  String title;
  String body;

  NotificationService(this.title, this.body);

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await __notification.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: $payload');
      }
    });
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidChannel =
        AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidChannel);

    // Generate random number
    int randomNumber = Random().nextInt(100);

    await __notification.show(
        randomNumber, this.title, this.body, platformChannelSpecifics);

    // Schedule a notification to be shown in 5 seconds.
    // await __notification.zonedSchedule(
    //     0, title, body, _nextInstanceOfSevenAM(), platformChannelSpecifics,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime,
    //     androidAllowWhileIdle: true,
    //     matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOfSevenAM() {
    var kolkata = tz.getLocation('Asia/Kolkata');
    final tz.TZDateTime now = tz.TZDateTime.now(kolkata);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(kolkata, now.year, now.month, now.day, 20, 58);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
