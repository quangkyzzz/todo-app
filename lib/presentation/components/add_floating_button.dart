import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

class AddFloatingButton extends StatelessWidget {
  const AddFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
      ),
      onPressed: () {
        bool isChecked = false;
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return AddTaskItem(isChecked: isChecked);
          },
        );
      },
      child: const Icon(
        Icons.add,
        size: 40,
        color: MyTheme.whiteColor,
      ),
    );
  }
}

// ignore: must_be_immutable
class AddTaskItem extends StatelessWidget {
  bool isChecked;
  AddTaskItem({super.key, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
      },
    );
  }
}
