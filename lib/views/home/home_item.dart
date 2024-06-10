import 'package:flutter/material.dart';
import 'package:todo_app/views/task_list/task_list_view.dart';

class HomeItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  const HomeItem({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            TaskListView.route(),
          );
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}
