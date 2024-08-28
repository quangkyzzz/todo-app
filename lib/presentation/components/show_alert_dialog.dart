import 'package:flutter/material.dart';
import '../../themes.dart';

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
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
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
