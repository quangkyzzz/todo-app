// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../../themes.dart';

class CustomPopupItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const CustomPopupItem({
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
        const SizedBox(width: 16),
        Text(
          text,
          style: MyTheme.itemSmallTextStyle,
        ),
      ]),
    );
  }
}
