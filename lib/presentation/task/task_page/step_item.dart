import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            context
                .read<TaskViewModel>()
                .updateStepIsCompleted(stepID: step.id, isCompleted: value!);
          },
        ),
        Expanded(
          child: TextField(
            controller: controller
              ..selection = TextSelection.fromPosition(TextPosition(
                offset: controller.text.length,
              )),
            onSubmitted: (value) {
              context
                  .read<TaskViewModel>()
                  .updateStepName(stepID: step.id, newName: value);
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
              context
                  .read<TaskViewModel>()
                  .updateStepName(stepID: step.id, newName: controller.text);
            },
          ),
        ),
        PopupMenuButton(itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              onTap: () {
                context.read<TaskViewModel>().deleteStep(stepID: step.id);
              },
              child: const CustomPopupItem(
                text: 'Promote to task',
                icon: Icons.add_outlined,
              ),
            ),
            PopupMenuItem(
              onTap: () {
                context.read<TaskViewModel>().deleteStep(stepID: step.id);
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
