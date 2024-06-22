import 'package:flutter/material.dart';
import 'package:todo_app/constant/app_configs.dart';

class MyDayFloatingButton extends StatefulWidget {
  const MyDayFloatingButton({super.key});

  @override
  State<MyDayFloatingButton> createState() => _MyDayFloatingButtonState();
}

class _MyDayFloatingButtonState extends State<MyDayFloatingButton> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            color: AppConfigs.blueColor,
          ),
          child: InkWell(
            splashColor: AppConfigs.blackColor,
            customBorder: const CircleBorder(),
            onTap: () {
              onSuggestionsTap(context);
            },
            child: Ink(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const Text(
                'Suggestions',
                style: AppConfigs.itemTextStyle,
              ),
            ),
          ),
        ),
        const Spacer(flex: 1),
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppConfigs.blueColor,
          ),
          child: InkWell(
            splashColor: AppConfigs.blackColor,
            customBorder: const CircleBorder(),
            onTap: () {
              onAddTaskTap(context);
            },
            child: Ink(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              height: 60,
              width: 60,
              child: const Icon(
                Icons.add,
                size: 40,
                color: AppConfigs.whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> onAddTaskTap(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            color: AppConfigs.backgroundGreyColor,
            child: Row(
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
                const Expanded(
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Add a task',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_upward),
                )
              ],
            ),
          );
        });
      },
    );
  }

  Future<dynamic> onSuggestionsTap(BuildContext context) {
    return showModalBottomSheet(
      showDragHandle: true,
      constraints: const BoxConstraints(maxHeight: 200),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'From earlier',
                style: AppConfigs.itemTextStyle,
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
                    style: AppConfigs.itemTextStyle,
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
