import 'package:flutter/material.dart';
import '../../themes.dart';
import '../../ultility/enum.dart';

Future<(int, Frequency)?> showCustomRepeatTimeDialog(BuildContext context) {
  return showDialog<(int, Frequency)>(
    context: context,
    builder: (context) {
      TextEditingController controller = TextEditingController(text: '1');
      Frequency selectedFrequency = Frequency.day;
      List<Frequency> listPopUpMennu = Frequency.values.toList()
        ..remove(Frequency.weekday);
      return StatefulBuilder(builder: (context, setState) {
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
                    padding: EdgeInsets.zero,
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
                    padding: EdgeInsets.zero,
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
                        child: Text(item.value),
                        onTap: () {
                          setState(() {
                            selectedFrequency = item;
                          });
                        },
                      );
                    }).toList();
                  },
                  child: Text(selectedFrequency.value),
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

                  (int, Frequency) result = (numberOfDay, selectedFrequency);
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
