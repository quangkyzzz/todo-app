// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

Future<String?> showHomeDialog(
  BuildContext context,
  String title,
  String hintText,
  String positiveButton,
) {
  TextEditingController controller = TextEditingController();
  return showDialog<String?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
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
            onPressed: () {
              Navigator.pop(context, controller.text);
            },
            child: Text(positiveButton),
          )
        ],
      );
    },
  );
}
