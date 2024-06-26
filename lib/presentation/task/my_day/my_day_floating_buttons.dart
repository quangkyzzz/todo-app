import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/components/add_floating_button.dart';

class MyDayFloatingButtons extends StatefulWidget {
  const MyDayFloatingButtons({super.key});

  @override
  State<MyDayFloatingButtons> createState() => _MyDayFloatingButtonsState();
}

class _MyDayFloatingButtonsState extends State<MyDayFloatingButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(18),
            color: MyTheme.blueColor,
          ),
          child: InkWell(
            splashColor: MyTheme.blackColor,
            customBorder: const CircleBorder(),
            onTap: () {
              onSuggestionsTap(context);
            },
            child: Ink(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const Text(
                'Suggestions',
                style: MyTheme.itemTextStyle,
              ),
            ),
          ),
        ),
        const Spacer(flex: 1),
        const AddFloatingButton(),
      ],
    );
  }

  Future<dynamic> onSuggestionsTap(BuildContext context) {
    bool isChecked = false;
    return showModalBottomSheet(
      showDragHandle: true,
      constraints: const BoxConstraints(maxHeight: 198),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'From earlier',
                style: MyTheme.itemTextStyle,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    shape: const CircleBorder(),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Text(
                    'Task 1',
                    style: MyTheme.itemTextStyle,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_outlined),
                  )
                ],
              ),
            ],
          );
        });
      },
    );
  }
}
