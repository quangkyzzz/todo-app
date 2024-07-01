import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

class TaskPageItem extends StatefulWidget {
  final bool isActive;
  final IconData icon;
  final String text;
  final Function() onTap;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isActive = widget.isActive;
    print('building inside with isActive: ${isActive}');
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
          onPressed: widget.onTap,
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
