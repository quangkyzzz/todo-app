import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';

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
          style: AppConfigs.itemTextStyle,
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
              style: TextStyle(color: AppConfigs.redColor),
            ),
          )
        ],
      );
    },
  );
}
