import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/components/show_alert_dialog.dart';
import 'package:intl/intl.dart';

class TaskPageBottomNavigation extends StatelessWidget {
  final TaskModel task;
  const TaskPageBottomNavigation({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
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
          Text(
            'Create at ${DateFormat.MMMEd('en_US').add_jm().format(task.createDate)}',
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
