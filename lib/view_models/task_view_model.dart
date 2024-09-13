import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/task_list.dart';
import '../models/task_step.dart';
import '../ultility/type_def.dart';

//TODO: continue to fix this
class TaskViewModel extends ChangeNotifier {
  TaskMapList allTask = [
    {
      Task(
        id: '2',
        title: 'few day',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ): TaskList(
        id: '1',
        listName: 'Tasks',
      )
    },
    {
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
      ): TaskList(
        id: '1',
        listName: 'Tasks',
      )
    },
    {
      Task(
        id: '66',
        title: 'No step',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        remindTime: DateTime(2024, 9, 1),
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ): TaskList(
        id: '1',
        listName: 'Tasks',
      )
    },
    {
      Task(
        id: '3',
        title: 'few hour',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 7),
        note: 'Really long note, long long long'
            'long long long long long long',
      ): TaskList(
        id: '222',
        listName: 'personal list 1',
        backgroundImage: '/data/user/0/com.example.todo_app/cache/'
            'file_picker/1723799643254/1000000837.jpg',
      )
    },
    {
      Task(
        id: '4',
        title: 'recent',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: false,
        createDate: DateTime(2024, 7, 2, 9, 38),
      ): TaskList(
        id: '222',
        listName: 'personal list 1',
        backgroundImage: '/data/user/0/com.example.todo_app/cache/'
            'file_picker/1723799643254/1000000837.jpg',
      )
    },
    {
      Task(
        id: '5',
        title: 'few minute',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 9, 30),
      ): TaskList(
        id: '222',
        listName: 'personal list 1',
        backgroundImage: '/data/user/0/com.example.todo_app/cache/'
            'file_picker/1723799643254/1000000837.jpg',
      )
    },
  ];

  TaskMapList getOnMyDayTask() {
    TaskMapList result = [];
    for (var pair in allTask) {
      if (pair.keys.first.isOnMyDay) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList getImportantTask() {
    TaskMapList result = [];
    for (var pair in allTask) {
      if (pair.keys.first.isImportant) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList getPlannedTask() {
    TaskMapList result = [];
    for (var pair in allTask) {
      if (pair.keys.first.dueDate != null) {
        result.add(pair);
      }
    }
    return result;
  }
}
