// ignore_for_file: discarded_futures

import 'package:todo_app/models/enum.dart';
import 'package:todo_app/service/notification_service.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    String title = inputData!['title'];
    String body = inputData['taskTitle'];
    int id = int.parse(inputData['id']);
    bool isPlaySound = inputData['isPlaySound'];
    bool isWeekDay = inputData['isWeekDay'] ?? false;
    bool isMonthly = inputData['isMonthly'] ?? false;
    bool isYearly = inputData['isYearly'] ?? false;
    int frequencyMultiplier = inputData['frequencyMultiplier'] ?? 1;
    int remindDay = inputData['remindDay'] ?? 1;
    int remindMonth = inputData['remindMonth'] ?? 1;
    int remindYear = inputData['remindYear'] ?? 1;
    DateTime today = DateTime.now();
    bool isExecute = false;
    if ((isWeekDay) && (today.weekday < 6)) {
      isExecute = true;
    } else if ((isMonthly) &&
        (today.day == remindDay) &&
        (((today.month - remindMonth) % frequencyMultiplier) == 0)) {
      isExecute = true;
    } else if ((isYearly) &&
        (today.day == remindDay) &&
        (today.month == remindMonth) &&
        (((today.year - remindYear) % frequencyMultiplier) == 0)) {
      isExecute = true;
    } else if ((!isWeekDay) && (!isMonthly) && (!isYearly)) {
      isExecute = true;
    }

    if (isExecute) {
      await NotificationService.showLocalNotification(
        id: id,
        title: title,
        body: body,
        isPlaySound: isPlaySound,
      );
    }
    return Future.value(true);
  });
}

class BackGroundService {
  static void executePeriodicBackGroundTask({
    required String taskID,
    required String taskTitle,
    required String taskListTitle,
    required DateTime remindTime,
    required Frequency frequency,
    required int frequencyMultiplier,
    required bool isPlaySound,
  }) async {
    bool isWeekDay = false;
    bool isMonthly = false;
    bool isYearly = false;
    int remindDay = remindTime.day;
    int remindMonth = remindTime.month;
    int remindYear = remindTime.year;

    Duration delayTime = remindTime.difference(DateTime.now());

    BackGroundService.cancelTaskByID(id: taskID);
    if (delayTime.inSeconds < 0) {
      int secondDelay = delayTime.inSeconds % const Duration(days: 1).inSeconds;
      delayTime = Duration(seconds: secondDelay);
    }
    late Duration waitDuration;
    switch (frequency) {
      case Frequency.day:
        waitDuration = Duration(days: frequencyMultiplier);
      case Frequency.weekday:
        {
          waitDuration = const Duration(days: 1);
          isWeekDay = true;
        }
      case Frequency.week:
        waitDuration = Duration(days: frequencyMultiplier * 7);
      case Frequency.month:
        {
          waitDuration = const Duration(days: 1);
          isMonthly = true;
        }
      case Frequency.year:
        {
          waitDuration = const Duration(days: 1);
          isYearly = true;
        }
    }
    await Workmanager().registerPeriodicTask(
      taskID,
      taskTitle,
      initialDelay: delayTime,
      frequency: waitDuration,
      inputData: {
        'id': (taskID.length > 10) ? taskID.substring(6) : taskID,
        'taskTitle': taskTitle,
        'title': taskListTitle,
        'remindYear': remindYear,
        'remindMonth': remindMonth,
        'remindDay': remindDay,
        'isPlaySound': isPlaySound,
        'isWeekDay': isWeekDay,
        'isMonthly': isMonthly,
        'isYearly': isYearly,
        'frequencyMultiplier': frequencyMultiplier,
      },
    );
  }

  static void executeScheduleBackGroundTask({
    required String taskTitle,
    required String taskID,
    required String taskListTitle,
    required bool isPlaySound,
    required DateTime remindTime,
  }) async {
    Duration delayTime = remindTime.difference(DateTime.now());
    if (delayTime.inSeconds > 0) {
      await Workmanager().registerOneOffTask(
        taskID,
        taskTitle,
        initialDelay: delayTime,
        inputData: {
          'id': (taskID.length > 10) ? taskID.substring(6) : taskID,
          'taskTitle': taskTitle,
          'title': taskListTitle,
          'isPlaySound': isPlaySound,
        },
      );
    }
  }

  static void cancelTaskByID({required String id}) {
    if (id.length > 10) {
      NotificationService.cancelNotification(int.parse(id.substring(6)));
    } else {
      NotificationService.cancelNotification(int.parse(id));
    }
    Workmanager().cancelByUniqueName(id);
  }

  static Future<void> cancelAllTask() async {
    await NotificationService.cancelAllNotification();
    await Workmanager().cancelAll();
  }
}
