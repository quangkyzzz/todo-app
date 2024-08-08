import 'package:flutter/material.dart';

Future<Duration?> showCustomRepeatTimeDialog(BuildContext context) {
  return showDialog<Duration>(
    context: context,
    builder: (context) {
      int popUpIndex = 0;
      List<Map<String, dynamic>> listPopUpMennu = [
        {
          'index': 0,
          'text': 'Days',
          'value': 1,
        },
        {
          'index': 1,
          'text': 'Weeks',
          'value': 7,
        },
        {
          'index': 2,
          'text': 'Months',
          'value': 30,
        },
        {
          'index': 3,
          'text': 'Years',
          'value': 365,
        },
      ];

      return StatefulBuilder(builder: (context, setState) {
        TextEditingController controller = TextEditingController(text: '1');
        return AlertDialog(
          title: const Text('Repeat every:'),
          content: Row(
            children: [
              TextField(
                controller: controller,
                maxLength: 3,
                decoration: const InputDecoration(
                    counterText: '',
                    constraints: BoxConstraints(
                      maxWidth: 40,
                    )),
                keyboardType: TextInputType.number,
              ),
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return listPopUpMennu.map((item) {
                    return PopupMenuItem(
                      child: Text(item['text']),
                      onTap: () {
                        setState(() {
                          popUpIndex = item['index'];
                        });
                      },
                    );
                  }).toList();
                },
                child: Text(listPopUpMennu[popUpIndex]['text']),
              )
            ],
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
                if (controller.text.isEmpty) {
                  Navigator.pop(context);
                } else {
                  int numberOfDay = int.parse(controller.text) *
                      listPopUpMennu[popUpIndex]['value'] as int;
                  Duration result = Duration(days: numberOfDay);
                  Navigator.pop(context, result);
                }
              },
              child: const Text('Save'),
            )
          ],
        );
      });
    },
  );
}
