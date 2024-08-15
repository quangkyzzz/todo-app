import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/notification_service.dart';
import 'package:workmanager/workmanager.dart';

//TODO: check logic and test this
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    String title = inputData!['listName'];
    String body = inputData['taskTitle'];
    int id = int.parse(inputData['id']);
    bool isPlaySound = inputData['isPlaySound'];
    bool isWeekDay = inputData['isWeekDay'] ?? false;
    bool isMonthly = inputData['isMonthly'] ?? false;
    bool isYearly = inputData['isYearly'] ?? false;
    int period = inputData['period'] ?? 1;
    int remindDay = inputData['remindDay'] ?? 1;
    int remindMonth = inputData['remindMonth'] ?? 1;
    int remindYear = inputData['remindYear'] ?? 1;
    DateTime today = DateTime.now();
    bool isExecute = false;
    if ((isWeekDay) && (today.weekday < 6)) {
      isExecute = true;
    } else if ((isMonthly) &&
        (today.day == remindDay) &&
        (((today.month - remindMonth) % period) == 0)) {
      isExecute = true;
    } else if ((isYearly) &&
        (today.day == remindDay) &&
        (today.month == remindMonth) &&
        (((today.year - remindYear) % period) == 0)) {
      isExecute = true;
    } else if ((!isWeekDay) && (!isMonthly) && (!isYearly)) {
      isExecute = true;
    }

    if (isExecute) {
      NotificationService.showLocalNotification(
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
    required TaskModel task,
    required TaskListModel taskList,
    required DateTime remindTime,
    required String frequency,
    required bool isPlaySound,
  }) {
    bool isWeekDay = false;
    bool isMonthly = false;
    bool isYearly = false;
    int remindDay = remindTime.day;
    int remindMonth = remindTime.month;
    int remindYear = remindTime.year;

    Duration delayTime = remindTime.difference(DateTime.now());
    int period = int.parse(frequency.split(' ').first);
    String interval = frequency.split(' ')[1];

    cancelTaskByID(id: task.id);

    late Duration frequencyDuration;
    switch (interval) {
      case 'Days':
        frequencyDuration = Duration(minutes: 15 + period /*period*/);
      case 'Weekdays':
        {
          frequencyDuration = const Duration(minutes: 15);
          isWeekDay = true;
        }
      case 'Weeks':
        frequencyDuration = Duration(minutes: 15 + period /*period * 7*/);
      case 'Months':
        {
          frequencyDuration = const Duration(minutes: 15);
          isMonthly = true;
        }
      case 'Years':
        {
          frequencyDuration = const Duration(minutes: 15);
          isYearly = true;
        }
    }
    Workmanager().registerPeriodicTask(
      task.id,
      task.title,
      initialDelay: delayTime,
      frequency: frequencyDuration,
      inputData: {
        'id': task.id,
        'taskTitle': task.title,
        'listName': taskList.listName,
        'remindYear': remindYear,
        'remindMonth': remindMonth,
        'remindDay': remindDay,
        'isPlaySound': isPlaySound,
        'isWeekDay': isWeekDay,
        'isMonthly': isMonthly,
        'isYearly': isYearly,
        'period': period,
      },
    );
  }

  static void executeScheduleBackGroundTask({
    required TaskModel task,
    required TaskListModel taskList,
    required bool isPlaySound,
    required DateTime remindTime,
  }) {
    Duration delayTime = remindTime.difference(DateTime.now());
    if (delayTime.inSeconds > 0) {
      Workmanager().registerOneOffTask(
        task.id,
        task.title,
        initialDelay: delayTime,
        inputData: {
          'id': task.id,
          'taskTitle': task.title,
          'listName': taskList.listName,
          'isPlaySound': isPlaySound,
        },
      );
    }
  }

  // static void setRepeatToTask({
  //   required TaskModel task,
  //   required TaskListModel taskList,
  //   required String frequency,
  //   required DateTime remindTime,
  //   required bool isPlaySound,
  // }) {
  //   cancelTaskByID(id: task.id);

  //   exercutePeriodicBackGroundTask(
  //     task: task,
  //     taskList: taskList,
  //     isPlaySound: isPlaySound,
  //   );
  // }

  static void cancelTaskByID({required String id}) {
    NotificationService.cancelNotification(int.parse(id));
    Workmanager().cancelByUniqueName(id);
  }

  static void cancelAllTask() {
    NotificationService.cancelAllNotification();
    Workmanager().cancelAll();
  }
}
