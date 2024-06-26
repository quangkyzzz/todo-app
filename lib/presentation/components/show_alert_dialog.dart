import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

Future<dynamic> showAlertDialog(
  BuildContext context,
  String title,
  String content,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: MyTheme.itemTextStyle,
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: MyTheme.redColor),
            ),
          )
        ],
      );
    },
  );
}
