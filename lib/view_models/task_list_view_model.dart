import 'package:flutter/material.dart';
import '../models/group.dart';
import '../models/task_step.dart';
import '../models/task_list.dart';
import '../models/task.dart';
import '../service/background_service.dart';
import '../themes.dart';

class TaskListViewModel extends ChangeNotifier {
  List<TaskList> taskLists = [
    TaskList(
      id: '1',
      listName: 'Tasks',
      tasks: [
        Task(
          id: '2',
          title: 'few day',
          isCompleted: false,
          isImportant: true,
          isOnMyDay: true,
          createDate: DateTime(2024, 6, 2),
          dueDate: DateTime(2024, 6, 2),
        ),
        Task(
          id: '1',
          title: 'Tasks',
          isCompleted: false,
          isImportant: false,
          isOnMyDay: false,
          createDate: DateTime(2024, 6, 9),
          stepList: [
            TaskStep(
              id: '1',
              stepName: 'step 1',
              isCompleted: false,
            ),
            TaskStep(
              id: '2',
              stepName: 'step 2',
              isCompleted: true,
            ),
          ],
          note: 'note',
        ),
        Task(
          id: '66',
          title: 'No step',
          isCompleted: false,
          isImportant: false,
          isOnMyDay: true,
          remindTime: DateTime(2024, 9, 1),
          createDate: DateTime(2024, 6, 2),
          dueDate: DateTime(2024, 6, 2),
        ),
      ],
    ),
    TaskList(
      id: '2',
      listName: 'My Day',
      themeColor: MyTheme.whiteColor,
      backgroundImage: 'assets/backgrounds/bg_my_day.jpg',
      defaultImage: 0,
    ),
    TaskList(id: '3', listName: 'Important', themeColor: MyTheme.pinkColor),
    TaskList(id: '4', listName: 'Planned', themeColor: MyTheme.redColor),
    TaskList(
        id: '5', listName: 'Assigned to me', themeColor: MyTheme.greenColor),
    TaskList(
        id: '6', listName: 'Flagged email', themeColor: MyTheme.orangeColor),
    TaskList(
      id: '222',
      listName: 'personal list 1',
      backgroundImage: '/data/user/0/com.example.todo_app/cache/'
          'file_picker/1723799643254/1000000837.jpg',
      tasks: [
        Task(
            id: '3',
            title: 'few hour',
            isCompleted: false,
            isImportant: false,
            isOnMyDay: true,
            createDate: DateTime(2024, 7, 2, 7),
            note: 'Really long note, long long long'
                'long long long long long long'),
        Task(
          id: '4',
          title: 'recent',
          isCompleted: false,
          isImportant: true,
          isOnMyDay: false,
          createDate: DateTime(2024, 7, 2, 9, 38),
        ),
        Task(
          id: '5',
          title: 'few minute',
          isCompleted: false,
          isImportant: true,
          isOnMyDay: true,
          createDate: DateTime(2024, 7, 2, 9, 30),
        ),
      ],
    ),
  ];

  TaskList getTaskList({
    required String taskListID,
  }) {
    return taskLists.firstWhere((element) => (element.id == taskListID));
  }

  TaskList getTaskListFromGroup({
    required String taskListID,
    required Group group,
  }) {
    return group.taskLists.firstWhere((element) => (element.id == taskListID));
  }

  void createTaskList({
    required String name,
  }) {
    TaskList newTaskList = TaskList(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      listName: name,
    );
    taskLists.add(newTaskList);
    notifyListeners();
  }

  void addTaskList({
    required List<TaskList> addTaskLists,
  }) {
    taskLists.addAll(addTaskLists);
    notifyListeners();
  }

  void deleteTaskList({
    required String taskListID,
  }) {
    TaskList taskList = getTaskList(taskListID: taskListID);
    for (Task task in taskList.tasks) {
      // ignore: unawaited_futures
      BackGroundService.cancelTaskByID(id: task.id);
    }

    taskLists.remove(taskList);
    notifyListeners();
  }

  void deleteMultipleTaskList({
    required List<TaskList> deleteTaskLists,
  }) {
    taskLists.removeWhere((element) => (deleteTaskLists.contains(element)));
    notifyListeners();
  }

  void cutTaskList({required String taskListID}) {
    taskLists.removeWhere((element) => (element.id == taskListID));
    notifyListeners();
  }
}
