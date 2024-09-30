import 'package:flutter/material.dart';
import '../../../models/task_step.dart';
import '../../items/popup_item.dart';
import '../../../themes.dart';

class StepItem extends StatelessWidget {
  final TaskStep step;
  final String taskListID;
  final Function callBack;
  const StepItem({
    super.key,
    required this.step,
    required this.callBack,
    required this.taskListID,
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
            callBack(step.copyWith(isCompleted: value));
          },
        ),
        Expanded(
          child: TextField(
            controller: controller,
            onSubmitted: (value) {
              step.stepName = value;
              callBack(step.copyWith(stepName: value));
            },
          ),
        ),
        PopupMenuButton(itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              onTap: () {
                callBack(step, isDelete: true);
                //TODO: implement this

                // taskViewModel.createTask(
                //   taskListID: taskListID,
                //   taskName: step.stepName,
                //   isCompleted: step.isCompleted,
                // );
              },
              child: const CustomPopupItem(
                text: 'Promote to task',
                icon: Icons.add_outlined,
              ),
            ),
            PopupMenuItem(
              onTap: () {
                callBack(step, isDelete: true);
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
