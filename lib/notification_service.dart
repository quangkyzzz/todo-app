import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:todo_app/themes.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  NotificationService();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  static Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation(await FlutterTimezone.getLocalTimezone()),
    );
  }

  static Future<NotificationDetails> _notificationDetails(
      bool isPlaySound) async {
    AndroidNotificationDetails androidPlatform = AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'dd',
      channelDescription: 'des',
      importance: Importance.max,
      priority: Priority.max,
      playSound: isPlaySound,
      ticker: 'ticker',
      color: MyTheme.blueColor,
    );
    // final details =
    //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatform,
    );
    return platformChannelSpecifics;
  }

  static Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required bool isPlaySound,
  }) async {
    final platformChannelSpecifics = await _notificationDetails(isPlaySound);
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  static Future<void> setScheduleNotification({
    required DateTime scheduleDateTime,
    required String title,
    required String body,
    required int id,
    required bool isPlaySound,
  }) async {
    final platformChannelSpecifics = await _notificationDetails(isPlaySound);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime(
        tz.local,
        scheduleDateTime.year,
        scheduleDateTime.month,
        scheduleDateTime.day,
        scheduleDateTime.hour,
        scheduleDateTime.minute,
      ),
      platformChannelSpecifics,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> setPeriodicNotification({
    required int id,
    required String title,
    required String body,
    required bool isPlaySound,
  }) async {
    final platformChannelSpecifics = await _notificationDetails(isPlaySound);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
