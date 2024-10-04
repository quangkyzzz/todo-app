import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task.dart';
import '../../../themes.dart';
import '../../../view_models/task_view_model.dart';

class TaskEditRow extends StatelessWidget {
  const TaskEditRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Task watchCurrentTask = context.watch<TaskViewModel>().currentTask;
    TextEditingController textEditingController = TextEditingController(
      text: context.read<TaskViewModel>().currentTask.title,
    );
    return Row(
      children: [
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            activeColor: MyTheme.blueColor,
            value: watchCurrentTask.isCompleted,
            shape: const CircleBorder(),
            onChanged: (bool? value) {
              Task updatedTask = context.read<TaskViewModel>().currentTask;
              updatedTask.isCompleted = value!;
              context
                  .read<TaskViewModel>()
                  .updateTask(updatedTask: updatedTask);
            },
          ),
        ),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(border: InputBorder.none),
            style: MyTheme.titleTextStyle,
            controller: textEditingController,
            onSubmitted: (String value) {
              Task updatedTask = context.read<TaskViewModel>().currentTask;
              updatedTask.title = value;
              context
                  .read<TaskViewModel>()
                  .updateTask(updatedTask: updatedTask);
            },
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            Task updatedTask = context.read<TaskViewModel>().currentTask;

            updatedTask.isImportant =
                !context.read<TaskViewModel>().currentTask.isImportant;
            context.read<TaskViewModel>().updateTask(updatedTask: updatedTask);
          },
          child: (watchCurrentTask.isImportant)
              ? Transform.scale(
                  scale: 1.3,
                  child: const Icon(
                    Icons.star,
                    color: MyTheme.blueColor,
                  ),
                )
              : Transform.scale(
                  scale: 1.3, child: const Icon(Icons.star_border_outlined)),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
