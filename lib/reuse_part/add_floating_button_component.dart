import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';

class AddFloatingButtonComponent extends StatelessWidget {
  const AddFloatingButtonComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppConfigs.blueColor,
      ),
      child: InkWell(
        splashColor: AppConfigs.blackColor,
        customBorder: const CircleBorder(),
        onTap: () {
          bool isChecked = false;
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
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
    );
  }
}
