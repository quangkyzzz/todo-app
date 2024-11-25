import 'package:todo_app/model/data/task_data_source/firebase_task_database.dart';
import 'package:todo_app/model/data/task_data_source/task_data_template.dart';
import 'package:todo_app/model/entity/enum.dart';
import 'package:todo_app/model/entity/task.dart';
import 'package:todo_app/model/entity/task_step.dart';

class TaskRepository implements TaskDataTemplate {
  TaskDataTemplate dataSource;
  TaskRepository._internalConstructor(this.dataSource);
  factory TaskRepository.initDataSource() {
    return TaskRepository._internalConstructor(FirebaseTaskDatabase());
  }

  @override
  Future<List<Task>> getAllTask() async {
    return dataSource.getAllTask();
  }

  @override
  void addFile({
    required String groupID,
    required String taskListID,
    required String taskID,
    required List<String> filePath,
  }) {
    dataSource.addFile(
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
    dataSource.addStep(
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
    dataSource.createNewTask(
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
    dataSource.deleteStep(
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
    dataSource.deleteTask(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
    );
  }

  @override
  Future<Task> getTaskByID({
    required String groupID,
    required String taskListID,
    required String taskID,
  }) async {
    return await dataSource.getTaskByID(
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
    dataSource.removeFile(
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
    dataSource.updateDueDate(
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
    dataSource.updateFrequencyMultiplier(
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
    dataSource.updateIsCompleted(
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
    dataSource.updateIsImportant(
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
    dataSource.updateIsOnMyDay(
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
    dataSource.updateNote(
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
    dataSource.updateRemindTime(
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
    dataSource.updateRepeatFrequency(
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
    dataSource.updateStepIsCompleted(
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
    dataSource.updateStepName(
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
    dataSource.updateTaskTitle(
      groupID: groupID,
      taskListID: taskListID,
      taskID: taskID,
      newTitle: newTitle,
    );
  }
}
