import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/data_source/task_data_source/task_database_provider.dart';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_step.dart';

class FirebaseTaskDatabase implements TaskDatabaseProvider {
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
  Future<Task?> getTaskByID(
      {required String groupID,
      required String taskListID,
      required String taskID}) {
    // TODO: implement getTaskByID
    throw UnimplementedError();
  }

  @override
  void createNewTask(
      {required String groupID,
      required String taskListID,
      required Task newTask}) {
    // TODO: implement createNewTask
  }

  @override
  void deleteTask(
      {required String groupID,
      required String taskListID,
      required String taskID}) {
    // TODO: implement deleteTask
  }

  @override
  void updateTaskTitle(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required String newTitle}) {
    // TODO: implement updateTaskTitle
  }

  @override
  void updateDueDate(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required DateTime? dueDate}) {
    // TODO: implement updateDueDate
  }

  @override
  void updateFrequencyMultiplier(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required int frequencyMultiplier}) {
    // TODO: implement updateFrequencyMultiplier
  }

  @override
  void updateIsCompleted(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required bool isCompleted}) {
    // TODO: implement updateIsCompleted
  }

  @override
  void updateIsImportant(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required bool isImportant}) {
    // TODO: implement updateIsImportant
  }

  @override
  void updateIsOnMyDay(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required bool isOnMyDay}) {
    // TODO: implement updateIsOnMyDay
  }

  @override
  void updateNote(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required String newNote}) {
    // TODO: implement updateNote
  }

  @override
  void updateRemindTime(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required DateTime? remindTime}) {
    // TODO: implement updateRemindTime
  }

  @override
  void updateRepeatFrequency(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required Frequency? repeatFrequency}) {
    // TODO: implement updateRepeatFrequency
  }

  @override
  void addFile(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required List<String> filePath}) {
    // TODO: implement addFile
  }

  @override
  void removeFile(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required String filePath}) {
    // TODO: implement removeFile
  }

  @override
  void addStep(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required TaskStep newStep}) {
    // TODO: implement addStep
  }
  @override
  void deleteStep(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required String stepID}) {
    // TODO: implement deleteStep
  }

  @override
  void updateStepIsCompleted(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required String stepID,
      required bool isCompleted}) {
    // TODO: implement updateStepIsCompleted
  }

  @override
  void updateStepName(
      {required String groupID,
      required String taskListID,
      required String taskID,
      required String stepID,
      required String newName}) {
    // TODO: implement updateStepName
  }
}
