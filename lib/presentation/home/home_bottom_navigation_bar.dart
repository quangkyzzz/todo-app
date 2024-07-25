// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/notification_service.dart';
import 'package:todo_app/provider/group_provider.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';
import '../components/show_text_edit_dialog.dart';

class HomePageBottomNavigationBar extends StatelessWidget {
  const HomePageBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GroupProvider groupProvider =
        Provider.of<GroupProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 300, //TODO: fix to 352
            child: InkWell(
              onTap: () async {
                String? title = await showTextEditDialog(
                  context: context,
                  title: 'New list',
                  hintText: 'Enter your list title',
                  positiveButton: 'Create list',
                );
                if (!context.mounted) return;
                if (title != null) {
                  Provider.of<TaskListProvider>(context, listen: false)
                      .createTaskList(name: title);
                }
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: MyTheme.greyColor,
                    size: 30,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'New list',
                    style: MyTheme.itemGreyTextStyle,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: () async {
              // String? title = await showTextEditDialog(
              //   context: context,
              //   title: 'Create a group',
              //   hintText: 'Name this group',
              //   positiveButton: 'Create group',
              // );
              // if (!context.mounted) return;
              // if (title != null) {
              //   groupProvider.createGroup(title);
              // }
              DateTime date = DateTime(2024, 7, 25, 16, 5);
              await NotificationService.setPeriodicNotification(
                  id: 1, title: 'it time', body: 'body');
            },
            icon: const Icon(
              Icons.abc,
              color: MyTheme.greyColor,
              size: 32,
            ),
          ),
          IconButton(
            onPressed: () async {
              await NotificationService.cancelAllNotification();
            },
            icon: const Icon(Icons.cancel),
          )
        ],
      ),
    );
  }
}
