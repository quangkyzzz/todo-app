import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task.dart';
import '../../../models/task_step.dart';
import '../../../view_models/task_view_model.dart';
import '../../items/popup_item.dart';
import '../../../themes.dart';

class StepItem extends StatelessWidget {
  final TaskStep step;

  const StepItem({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: step.stepName);
    return Row(
      children: [
        Checkbox(
          activeColor: MyTheme.blueColor,
          shape: const CircleBorder(),
          value: step.isCompleted,
          onChanged: (bool? value) {
            Task updatedTask = context.read<TaskViewModel>().currentTask;
            updatedTask.stepList
                .firstWhere((e) => e.id == step.id)
                .isCompleted = value!;
            context.read<TaskViewModel>().updateTask(updatedTask: updatedTask);
          },
        ),
        Expanded(
          child: TextField(
            controller: controller,
            onSubmitted: (value) {
              step.stepName = value;
              Task updatedTask = context.read<TaskViewModel>().currentTask;
              updatedTask.stepList
                  .firstWhere((element) => element.id == step.id)
                  .stepName = value;
              context
                  .read<TaskViewModel>()
                  .updateTask(updatedTask: updatedTask);
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
              step.stepName = controller.text;
              Task updatedTask = context.read<TaskViewModel>().currentTask;
              updatedTask.stepList
                  .firstWhere((element) => element.id == step.id)
                  .stepName = controller.text;
              context
                  .read<TaskViewModel>()
                  .updateTask(updatedTask: updatedTask);
            },
          ),
        ),
        PopupMenuButton(itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              onTap: () {
                Task updatedTask = context.read<TaskViewModel>().currentTask;
                updatedTask.stepList.remove(step);
                context
                    .read<TaskViewModel>()
                    .updateTask(updatedTask: updatedTask);
              },
              child: const CustomPopupItem(
                text: 'Promote to task',
                icon: Icons.add_outlined,
              ),
            ),
            PopupMenuItem(
              onTap: () {
                Task updatedTask = context.read<TaskViewModel>().currentTask;
                updatedTask.stepList.remove(step);
                context
                    .read<TaskViewModel>()
                    .updateTask(updatedTask: updatedTask);
              },
              child: const CustomPopupItem(
                text: 'Delete step',
                icon: Icons.delete_outline,
              ),
            ),
          ];
        })
      ],
    );
  }
}
