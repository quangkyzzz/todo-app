import 'package:todo_app/data_source/task_data_source/firebase_task_database.dart';
import 'package:todo_app/data_source/task_data_source/task_database_provider.dart';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_step.dart';

class TaskDatabaseService implements TaskDatabaseProvider {
  TaskDatabaseProvider provider;
  TaskDatabaseService(this.provider);
  factory TaskDatabaseService.firebase() {
    return TaskDatabaseService(FirebaseTaskDatabase.initRef());
  }

  @override
  void addFile({
    required String groupID,
    required String taskListID,
    required String taskID,
    required List<String> filePath,
  }) {
    provider.addFile(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      filePath: filePath,
    );
  }

  @override
  void addStep({
    required String groupID,
    required String taskListID,
    required String taskID,
    required TaskStep newStep,
  }) {
    provider.addStep(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      newStep: newStep,
    );
  }

  @override
  void createNewTask({
    required String groupID,
    required String taskListID,
    required Task newTask,
  }) {
    provider.createNewTask(
      groupID: groupID,
      taskListID: taskListID,
      newTask: newTask,
    );
  }

  @override
  void deleteStep({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String stepID,
  }) {
    provider.deleteStep(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      stepID: stepID,
    );
  }

  @override
  void deleteTask({
    required String groupID,
    required String taskListID,
    required String taskID,
  }) {
    provider.deleteTask(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
    );
  }

  @override
  Future<Task?> getTaskByID({
    required String groupID,
    required String taskListID,
    required String taskID,
  }) async {
    return await provider.getTaskByID(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
    );
  }

  @override
  void removeFile({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String filePath,
  }) {
    provider.removeFile(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      filePath: filePath,
    );
  }

  @override
  void updateDueDate({
    required String groupID,
    required String taskListID,
    required String taskID,
    required DateTime? dueDate,
  }) {
    provider.updateDueDate(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      dueDate: dueDate,
    );
  }

  @override
  void updateFrequencyMultiplier({
    required String groupID,
    required String taskListID,
    required String taskID,
    required int frequencyMultiplier,
  }) {
    provider.updateFrequencyMultiplier(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      frequencyMultiplier: frequencyMultiplier,
    );
  }

  @override
  void updateIsCompleted({
    required String groupID,
    required String taskListID,
    required String taskID,
    required bool isCompleted,
  }) {
    provider.updateIsCompleted(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      isCompleted: isCompleted,
    );
  }

  @override
  void updateIsImportant({
    required String groupID,
    required String taskListID,
    required String taskID,
    required bool isImportant,
  }) {
    provider.updateIsImportant(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      isImportant: isImportant,
    );
  }

  @override
  void updateIsOnMyDay({
    required String groupID,
    required String taskListID,
    required String taskID,
    required bool isOnMyDay,
  }) {
    provider.updateIsOnMyDay(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      isOnMyDay: isOnMyDay,
    );
  }

  @override
  void updateNote({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String newNote,
  }) {
    provider.updateNote(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      newNote: newNote,
    );
  }

  @override
  void updateRemindTime({
    required String groupID,
    required String taskListID,
    required String taskID,
    required DateTime? remindTime,
  }) {
    provider.updateRemindTime(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      remindTime: remindTime,
    );
  }

  @override
  void updateRepeatFrequency({
    required String groupID,
    required String taskListID,
    required String taskID,
    required Frequency? repeatFrequency,
  }) {
    provider.updateRepeatFrequency(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      repeatFrequency: repeatFrequency,
    );
  }

  @override
  void updateStepIsCompleted({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String stepID,
    required bool isCompleted,
  }) {
    provider.updateStepIsCompleted(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      stepID: stepID,
      isCompleted: isCompleted,
    );
  }

  @override
  void updateStepName({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String stepID,
    required String newName,
  }) {
    provider.updateStepName(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      stepID: stepID,
      newName: newName,
    );
  }

  @override
  void updateTaskTitle({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String newTitle,
  }) {
    provider.updateTaskTitle(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      newTitle: newTitle,
    );
  }
}
