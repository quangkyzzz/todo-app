import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

class TaskPageItem extends StatefulWidget {
  final bool isActive;
  final IconData icon;
  final String text;
  final void Function() onTap;

  const TaskPageItem({
    super.key,
    required this.isActive,
    required this.icon,
    required this.text,
    required this.onTap,
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
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Transform.scale(
          scale: 1.3,
          child: Icon(
            widget.icon,
            color: (isActive) ? MyTheme.blueColor : MyTheme.greyColor,
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: (widget.text != 'Add to My Day')
              ? widget.onTap
              : () {
                  setState(() {
                    isActive = !isActive;
                  });
                },
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: (isActive) ? MyTheme.blueColor : MyTheme.greyColor,
            ),
          ),
        ),
        const Spacer(),
        (isActive)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isActive = !isActive;
                  });
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
