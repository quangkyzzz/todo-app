import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/entity/task.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/view_models/task_view_model.dart';

class TaskEditRow extends StatelessWidget {
  const TaskEditRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Task watchCurrentTask = context.watch<TaskViewModel>().currentTask;
    TextEditingController controller = TextEditingController(
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
              context
                  .read<TaskViewModel>()
                  .updateIsCompleted(isCompleted: value!);
            },
          ),
        ),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(border: InputBorder.none),
            style: MyTheme.titleTextStyle,
            controller: controller
              ..selection = TextSelection.fromPosition(TextPosition(
                offset: controller.text.length,
              )),
            onSubmitted: (String value) {
              context.read<TaskViewModel>().updateTaskTitle(newTitle: value);
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
              context
                  .read<TaskViewModel>()
                  .updateTaskTitle(newTitle: controller.text);
            },
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            context.read<TaskViewModel>().updateIsImportant(
                  isImportant:
                      !context.read<TaskViewModel>().currentTask.isImportant,
                );
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
