import 'package:flutter/material.dart';
import 'package:todo_app/constant/app_configs.dart';
import 'package:todo_app/models/task_model.dart';

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
            color: AppConfigs.greyColor,
            width: 0.3,
          ),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Create 1 hour ago',
            style: AppConfigs.itemGreyTextStyle,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Are you sure?',
                      style: AppConfigs.itemTextStyle,
                    ),
                    content:
                        Text(' "${task.title}" will be permanently deleted'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: AppConfigs.redColor),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            icon: Transform.scale(
              scale: 1.3,
              child: const Icon(
                Icons.delete_outline,
                color: AppConfigs.greyColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
