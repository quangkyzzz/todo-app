import 'package:flutter/material.dart';
import 'package:todo_app/Theme/theme.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          'item',
          style: TextStyle(color: AppConfigs.whiteColor),
        ),
      ],
    );
  }
}
