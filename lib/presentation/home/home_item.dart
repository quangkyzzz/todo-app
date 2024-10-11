import 'package:flutter/material.dart';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/models/task_list.dart';
import 'package:todo_app/themes.dart';

class HomeItem extends StatelessWidget {
  final TaskList taskList;
  final IconData icon;
  final Group? group;
  final int endNumber;
  final Function() onTap;
  const HomeItem({
    super.key,
    required this.icon,
    required this.endNumber,
    required this.onTap,
    required this.taskList,
    this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: taskList.themeColor,
            ),
            const SizedBox(width: 8),
            Text(
              taskList.title,
              style: MyTheme.itemTextStyle,
            ),
            const Spacer(
              flex: 1,
            ),
            ((endNumber != 0)
                ? Text(
                    endNumber.toString(),
                    style: const TextStyle(color: MyTheme.greyColor),
                  )
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
