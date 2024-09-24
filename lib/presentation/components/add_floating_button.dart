import 'package:flutter/material.dart';
import '../../models/task_list.dart';
import '../../themes.dart';
import 'add_task_bottom_sheet.dart';

class AddFloatingButton extends StatelessWidget {
  final Color themeColor;
  final TaskList taskList;
  final bool isAddToImportant;
  final bool isAddToMyDay;

  const AddFloatingButton({
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

class CustomTaskButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isHighLighted;
  final Function() onTap;
  final Function() onTapDisable;
  final String highLightText;
  final Color themeColor;
  const CustomTaskButton({
    super.key,
    required this.icon,
    required this.text,
    required this.isHighLighted,
    required this.onTap,
    required this.highLightText,
    required this.themeColor,
    required this.onTapDisable,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: (isHighLighted) ? themeColor : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: ((isHighLighted) && (themeColor == MyTheme.whiteColor))
                ? MyTheme.blackColor
                : MyTheme.whiteColor,
          ),
          const SizedBox(width: 4),
          (isHighLighted)
              ? Text(
                  highLightText,
                  style: (themeColor == MyTheme.whiteColor)
                      ? MyTheme.itemExtraSmallBlackTextStyle
                      : MyTheme.itemExtraSmallTextStyle,
                )
              : Text(
                  text,
                  style: MyTheme.itemSmallTextStyle,
                ),
          const SizedBox(width: 4),
          (isHighLighted)
              ? Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyTheme.dardGreyColor,
                  ),
                  height: 20,
                  width: 20,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onTapDisable,
                    icon: const Icon(Icons.close_outlined),
                    color: MyTheme.whiteColor,
                    iconSize: 16,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
