// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';

class ChangeThemeBottomSheet extends StatefulWidget {
  final TaskListModel taskList;
  const ChangeThemeBottomSheet({super.key, required this.taskList});

  @override
  State<ChangeThemeBottomSheet> createState() => _ChangeThemeBottomSheetState();
}

class _ChangeThemeBottomSheetState extends State<ChangeThemeBottomSheet> {
  late int _page;
  late Color _selectedColor;
  late TaskListProvider taskListProvider;

  onColorChange(Color value) {
    setState(() {
      _selectedColor = value;
    });
    TaskListModel newTaskList = widget.taskList.copyWith(themeColor: value);
    taskListProvider.updateTaskList(
      taskListID: widget.taskList.id,
      newTaskList: newTaskList,
    );
  }

  onPageChange(int value) {
    setState(() {
      _page = value;
    });
  }

  @override
  void initState() {
    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    _page = 0;
    _selectedColor = widget.taskList.themeColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pick a theme',
              style: MyTheme.itemTextStyle,
            ),
            Row(
              children: [
                CustomOutlinedButton(
                  isHighLighted: (_page == 0),
                  onTap: () {
                    onPageChange(0);
                  },
                  text: 'Color :',
                ),
                const SizedBox(width: 8),
                CustomOutlinedButton(
                  isHighLighted: (_page == 1),
                  onTap: () {
                    onPageChange(1);
                  },
                  text: 'Image :',
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: (_page == 0)
                  ? Row(
                      children: MyTheme.colorThemeList.map((color) {
                        return SelectColorButton(
                          onTap: () {
                            onColorChange(color);
                          },
                          color: color,
                          isHighLighted: (_selectedColor == color),
                        );
                      }).toList(),
                    )
                  : Text('image'),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectColorButton extends StatelessWidget {
  final Color color;
  final Function() onTap;
  final bool isHighLighted;
  const SelectColorButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.isHighLighted,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(50, 50),
        backgroundColor: color,
        shape: const CircleBorder(),
      ),
      child: (isHighLighted)
          ? const Icon(
              Icons.check_circle_outline,
              color: MyTheme.blackColor,
              size: 32,
            )
          : null,
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final bool isHighLighted;
  final Function() onTap;
  const CustomOutlinedButton({
    super.key,
    required this.isHighLighted,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(width: 1, color: MyTheme.whiteColor),
        backgroundColor: (isHighLighted) ? MyTheme.lightGreyColor : null,
      ),
      child: Text(
        text,
        style: MyTheme.itemSmallTextStyle,
      ),
    );
  }
}
