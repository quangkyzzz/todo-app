import 'package:todo_app/model/entity/enum.dart';
import 'package:todo_app/model/entity/task.dart';
import 'package:todo_app/model/entity/task_step.dart';

abstract class TaskDatabaseInterface {
  Future<Task> getTaskByID({
    required String groupID,
    required String taskListID,
    required String taskID,
  });

  Future<List<Task>> getAllTask();

  void createNewTask({
    required String groupID,
    required String taskListID,
    required Task newTask,
  });

  void deleteTask({
    required String groupID,
    required String taskListID,
    required String taskID,
  });

  void updateTaskTitle({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String newTitle,
  });

  void updateIsCompleted({
    required String groupID,
    required String taskListID,
    required String taskID,
    required bool isCompleted,
  });

  void updateIsImportant({
    required String groupID,
    required String taskListID,
    required String taskID,
    required bool isImportant,
  });

  void updateRemindTime({
    required String groupID,
    required String taskListID,
    required String taskID,
    required DateTime? remindTime,
  });

  void updateDueDate({
    required String groupID,
    required String taskListID,
    required String taskID,
    required DateTime? dueDate,
  });

  void updateRepeatFrequency({
    required String groupID,
    required String taskListID,
    required String taskID,
    required Frequency? repeatFrequency,
  });

  void updateFrequencyMultiplier({
    required String groupID,
    required String taskListID,
    required String taskID,
    required int frequencyMultiplier,
  });

  void updateIsOnMyDay({
    required String groupID,
    required String taskListID,
    required String taskID,
    required bool isOnMyDay,
  });

  void updateNote({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String newNote,
  });

  void addFile({
    required String groupID,
    required String taskListID,
    required String taskID,
    required List<String> filePath,
  });

  void removeFile({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String filePath,
  });

  void addStep({
    required String groupID,
    required String taskListID,
    required String taskID,
    required TaskStep newStep,
  });

  void deleteStep({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String stepID,
  });

  void updateStepName({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String stepID,
    required String newName,
  });

  void updateStepIsCompleted({
    required String groupID,
    required String taskListID,
    required String taskID,
    required String stepID,
    required bool isCompleted,
  });
}
