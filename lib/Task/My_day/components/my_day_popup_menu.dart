import 'package:flutter/material.dart';
import 'package:todo_app/Task/Task_list/components/task_list_popup_menu.dart';

class MyDayPopupMenu extends StatelessWidget {
  const MyDayPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskListPopupMenu(
      toRemove: ['reorder', 'duplicate_list', 'turn_onsuggestions'],
    );
  }
}

class PopupItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const PopupItem({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon),
      const SizedBox(width: 10),
      InkWell(child: Text(text)),
    ]);
  }
}
