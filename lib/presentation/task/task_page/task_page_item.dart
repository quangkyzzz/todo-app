import 'package:flutter/material.dart';
import '../../../models/task_list.dart';
import '../../../models/task.dart';
import '../../../themes.dart';

class TaskPageItem extends StatefulWidget {
  final TaskList taskList;
  final Task task;
  final bool isActive;
  final IconData icon;
  final String text;
  final String activeText;
  final void Function({bool isDisable}) onTap;

  const TaskPageItem({
    super.key,
    required this.isActive,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.taskList,
    required this.task,
    required this.activeText,
  });

  @override
  State<TaskPageItem> createState() => _TaskPageItemState();
}

class _TaskPageItemState extends State<TaskPageItem> {
  late bool isActive;
  @override
  void initState() {
    isActive = widget.isActive;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TaskPageItem oldWidget) {
    isActive = widget.isActive;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Icon(
          widget.icon,
          color: (isActive) ? MyTheme.blueColor : MyTheme.greyColor,
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: widget.onTap,
          child: Text(
            (isActive) ? widget.activeText : widget.text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: (isActive) ? MyTheme.blueColor : MyTheme.greyColor,
            ),
          ),
        ),
        const Spacer(),
        (isActive)
            ? IconButton(
                onPressed: () {
                  widget.onTap(isDisable: true);
                },
                icon: Transform.scale(
                  scale: 0.6,
                  child: const Icon(
                    Icons.close_outlined,
                    color: MyTheme.greyColor,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
