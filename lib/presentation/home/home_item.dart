import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themes.dart';
import '../../view_models/home_page_group_view_model.dart';
import '../../view_models/home_page_task_list_view_model.dart';

class HomeItem extends StatelessWidget {
  final String taskListID;
  final IconData icon;
  final String? groupID;
  final int endNumber;
  final Function() onTap;
  const HomeItem({
    super.key,
    required this.icon,
    required this.endNumber,
    required this.onTap,
    required this.taskListID,
    this.groupID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: (groupID != null)
                  ? context
                      .watch<HomePageGroupViewModel>()
                      .getTaskListFromGroup(
                        taskListID: taskListID,
                        groupID: groupID!,
                      )
                      .themeColor
                  : context
                      .watch<HomePageTaskListViewModel>()
                      .getTaskList(taskListID: taskListID)
                      .themeColor,
            ),
            const SizedBox(width: 8),
            Text(
              (groupID != null)
                  ? context
                      .watch<HomePageGroupViewModel>()
                      .getTaskListFromGroup(
                          taskListID: taskListID, groupID: groupID!)
                      .listName
                  : context
                      .read<HomePageTaskListViewModel>()
                      .getTaskList(taskListID: taskListID)
                      .listName,
              style: MyTheme.itemTextStyle,
            ),
            const Spacer(
              flex: 1,
            ),
            ((endNumber != 0)
                ? Text(
                    endNumber.toString(),
                    style: const TextStyle(color: MyTheme.greyColor),
                  )
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
