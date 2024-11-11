import 'package:flutter/material.dart';
import 'package:todo_app/model/entity/task_list.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/components/add_task_bottom_sheet.dart';

class AddTaskFloatingButton extends StatelessWidget {
  final Color themeColor;
  final TaskList taskList;
  final bool isAddToImportant;
  final bool isAddToMyDay;

  const AddTaskFloatingButton({
    super.key,
    required this.taskList,
    required this.themeColor,
    this.isAddToMyDay = false,
    this.isAddToImportant = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: themeColor,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
      ),
      onPressed: () async {
        await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext _) {
            return AddTaskBottomSheet(
              themeColor: themeColor,
              mContext: context,
              taskList: taskList,
              isAddToMyDay: isAddToMyDay,
              isAddToImportant: isAddToImportant,
            );
          },
        );
      },
      child: Icon(
        Icons.add,
        size: 40,
        color: (themeColor == MyTheme.whiteColor)
            ? MyTheme.blackColor
            : MyTheme.whiteColor,
      ),
    );
  }
}
