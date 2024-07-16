// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class HomeDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final String positiveButton;
  final Function() onTap;
  const HomeDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.positiveButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(positiveButton),
        )
      ],
    );
  }
}
