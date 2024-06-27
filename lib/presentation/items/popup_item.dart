// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Icon(
          icon,
          color: MyTheme.whiteColor,
        ),
        const SizedBox(width: 15),
        Text(
          text,
          style: MyTheme.itemSmallTextStyle,
        ),
      ]),
    );
  }
}
