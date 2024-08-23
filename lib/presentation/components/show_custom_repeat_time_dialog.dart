import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

Future<String?> showCustomRepeatTimeDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      int popUpIndex = 0;
      List<Map<String, dynamic>> listPopUpMennu = [
        {
          'index': 0,
          'text': 'Days',
        },
        {
          'index': 1,
          'text': 'Weeks',
        },
        {
          'index': 2,
          'text': 'Months',
        },
        {
          'index': 3,
          'text': 'Years',
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    onPressed: () {
                      int textNow = 0;
                      if (controller.text.isNotEmpty) {
                        textNow = int.parse(controller.text);
                      }
                      if (textNow < 999) {
                        controller.text = (textNow + 1).toString();
                      }
                    },
                    icon: const Icon(Icons.arrow_drop_up, size: 32),
                  ),
                  IconButton(
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    onPressed: () {
                      int textNow = 0;
                      if (controller.text.isNotEmpty) {
                        textNow = int.parse(controller.text);
                      }
                      if (textNow > 0) {
                        controller.text = (textNow - 1).toString();
                      }
                    },
                    icon: const Icon(Icons.arrow_drop_down, size: 32),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: MyTheme.whiteColor, width: 0.6),
                ),
                child: PopupMenuButton(
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
                ),
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
                if ((controller.text.isEmpty) || (controller.text == '0')) {
                  Navigator.pop(context);
                } else {
                  int numberOfDay = int.parse(controller.text);

                  String result =
                      '$numberOfDay ${listPopUpMennu[popUpIndex]['text']}';
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
