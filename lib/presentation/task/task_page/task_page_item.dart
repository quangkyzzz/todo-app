import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

class TaskPageItem extends StatelessWidget {
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
    required this.activeText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Icon(
          icon,
          color: (isActive) ? MyTheme.blueColor : MyTheme.greyColor,
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: onTap,
          child: Text(
            (isActive) ? activeText : text,
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
                  onTap(isDisable: true);
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
