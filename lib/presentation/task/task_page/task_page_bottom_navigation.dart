import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/components/show_alert_dialog_component.dart';

class TaskPageBottomNavigation extends StatelessWidget {
  final TaskModel task;
  const TaskPageBottomNavigation({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: MyTheme.greyColor,
            width: 0.3,
          ),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Create 1 hour ago',
            style: MyTheme.itemGreyTextStyle,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              showAlertDialog(
                context,
                'Are you sure?',
                ' "${task.title}" will be permanently deleted',
              );
            },
            icon: Transform.scale(
              scale: 1.3,
              child: const Icon(
                Icons.delete_outline,
                color: MyTheme.greyColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
