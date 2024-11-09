// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/data/task_data_source/task_database_provider.dart';
import 'package:todo_app/exception/data_exception.dart';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_list.dart';
import 'package:todo_app/models/task_step.dart';

class FirebaseTaskDatabase implements TaskDatabaseInterface {
  DatabaseReference ref;
  FirebaseTaskDatabase(this.ref);
  factory FirebaseTaskDatabase.initRef() {
    final FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://demoz-6f2fd-default-rtdb.asia-southeast1.firebasedatabase.app",
    );
    return FirebaseTaskDatabase(database.ref('groups'));
  }

  @override
  Future<List<Task>> getAllTask() async {
    List<Task> allTask = [];
    List<Group> allGroup = [];
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      var snapshotMap = snapshot.value as Map;
      snapshotMap.values.forEach((element) {
        allGroup.add(Group.fromMap(element));
      });
      for (Group group in allGroup) {
        for (TaskList taskList in group.taskLists) {
          allTask.addAll(taskList.tasks);
        }
      }
      return allTask;
    } else {
      throw DataDoesNotExist();
    }
  }

  @override
  Future<Task> getTaskByID({
    required String groupID,
    required String taskListID,
    required String taskID,
  }) async {
    Task result;
    DataSnapshot snapshot = await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
        .get();
    if (snapshot.exists) {
      Map resultMap = snapshot.value as Map;
      result = Task.fromMap(resultMap);
      return result;
    } else {
      throw DataDoesNotExist();
    }
  }

  @override
  void createNewTask({
    required String groupID,
    required String taskListID,
    required Task newTask,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id${newTask.id}')
        .set(newTask.toMap());
  }

  @override
  void deleteTask({
    required String groupID,
    required String taskListID,
    required String taskID,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
        .remove();
  }

  @override
  void updateTaskTitle({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String newTitle,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
        .update({'title': newTitle});
  }

  @override
  void updateDueDate({
    required String groupID,
    required String taskListID,
    required String taskID,
    required DateTime? dueDate,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
        .update({'dueDate': dueDate?.toString()});
  }

  @override
  void updateFrequencyMultiplier({
    required String groupID,
    required String taskListID,
    required String taskID,
    required int frequencyMultiplier,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
        .update({'frequencyMultiplier': frequencyMultiplier});
  }

  @override
  void updateIsCompleted({
    required String groupID,
    required String taskListID,
    required String taskID,
    required bool isCompleted,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
        .update({'isCompleted': isCompleted});
  }

  @override
  void updateIsImportant({
    required String groupID,
    required String taskListID,
    required String taskID,
    required bool isImportant,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
        .update({'isImportant': isImportant});
  }

  @override
  void updateIsOnMyDay({
    required String groupID,
    required String taskListID,
    required String taskID,
    required bool isOnMyDay,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
        .update({'isOnMyDay': isOnMyDay});
  }

  @override
  void updateNote({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String newNote,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
        .update({'note': newNote});
  }

  @override
  void updateRemindTime(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required DateTime? remindTime}) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
        .update({'remindTime': remindTime?.toString()});
  }

  @override
  void updateRepeatFrequency({
    required String groupID,
    required String taskListID,
    required String taskID,
    required Frequency? repeatFrequency,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
        .update({'repeatFrequency': repeatFrequency?.name});
  }

  @override
  void addFile({
    required String groupID,
    required String taskListID,
    required String taskID,
    required List<String> filePath,
  }) async {
    for (String file in filePath) {
      await ref
          .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID/filePath/')
          .child('id${file.hashCode}')
          .set(file);
    }
  }

  @override
  void removeFile({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String filePath,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID/filePath')
        .child('id${filePath.hashCode}')
        .remove();
  }

  @override
  void addStep({
    required String groupID,
    required String taskListID,
    required String taskID,
    required TaskStep newStep,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID/stepList/')
        .child('id${newStep.id}')
        .set(newStep.toMap());
  }

  @override
  void deleteStep({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String stepID,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID/stepList/')
        .child('id$stepID')
        .remove();
  }

  @override
  void updateStepIsCompleted({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String stepID,
    required bool isCompleted,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID/stepList/')
        .child('id$stepID')
        .update({'isCompleted': isCompleted});
  }

  @override
  void updateStepName({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String stepID,
    required String newName,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID/stepList/')
        .child('id$stepID')
        .update({'stepName': newName});
  }
}
