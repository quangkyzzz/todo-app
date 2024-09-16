import 'package:flutter/material.dart';
import '../models/group.dart';
import '../models/task_list.dart';
import '../models/task.dart';
import '../models/task_step.dart';
import '../themes.dart';

class GroupViewModel extends ChangeNotifier {
  List<Group> groups = [
    Group(
      id: '1',
      groupName: 'default group',
      taskLists: [
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
            id: '5',
            listName: 'Assigned to me',
            themeColor: MyTheme.greenColor),
        TaskList(
            id: '6',
            listName: 'Flagged email',
            themeColor: MyTheme.orangeColor),
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
      ],
    ),
    Group(
      id: '111',
      groupName: 'my group 1',
      taskLists: [
        TaskList(
          id: '333',
          listName: 'group 1 list 1',
          groupID: '111',
          tasks: [
            Task(
              id: '6',
              title: 'due today',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now(),
            ),
            Task(
              id: '7',
              title: 'due tomorrow',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 1)),
            ),
            Task(
              id: '8',
              title: 'due next week',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 7)),
            ),
          ],
        ),
        TaskList(
          id: '444',
          listName: 'group 1 list 2',
          groupID: '111',
          tasks: [
            Task(
              id: '9',
              title: 'due next month',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 31)),
            ),
            Task(
              id: '10',
              title: 'due next 2 day',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 2)),
            ),
            Task(
              id: '11',
              title: 'due next 3 day',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 3)),
            ),
          ],
        ),
      ],
    ),
    Group(
      id: '222',
      groupName: 'my group 2',
      taskLists: [
        TaskList(
          id: '555',
          listName: 'group 2 list 1',
          groupID: '222',
          tasks: [
            Task(
              id: '12',
              title: 'due next 4 day',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 4)),
            ),
          ],
        ),
        TaskList(
          id: '666',
          listName: 'group 2 list 2',
          groupID: '222',
        ),
      ],
    ),
  ];

  Group readGroupByID(String groupID) {
    return groups.firstWhere((element) => (element.id == groupID));
  }

  void createGroup(String name) {
    groups.add(Group(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      groupName: name,
    ));
    notifyListeners();
  }

  void createTaskListToGroup({
    required String name,
  }) {
    TaskList newTaskList = TaskList(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      listName: name,
    );
    groups[0].taskLists.add(newTaskList);
    notifyListeners();
  }

  void deleteGroup(Group group) {
    readGroupByID('1').taskLists.addAll(group.taskLists);
    groups.remove(group);
    notifyListeners();
  }

  void renameGroup(Group group, String newName) {
    groups.firstWhere((element) => (element.id == group.id)).groupName =
        newName;
    notifyListeners();
  }

  void addMultipleTaskListToGroup({
    required Group group,
    required List<TaskList> movedTaskLists,
  }) {
    for (var taskList in movedTaskLists) {
      readGroupByID(group.id).taskLists.add(taskList);
      readGroupByID('1').taskLists.remove(taskList);
    }

    notifyListeners();
  }

  void deleteMultipleTaskListFromGroup(
    Group group,
    List<TaskList> removedTaskLists,
  ) {
    for (var taskList in removedTaskLists) {
      readGroupByID(group.id).taskLists.remove(taskList);
      readGroupByID('1').taskLists.add(taskList);
    }

    notifyListeners();
  }
}
