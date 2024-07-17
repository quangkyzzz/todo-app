// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/group_provider.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';
import 'show_home_dialog.dart';

class HomePageBottomNavigationBar extends StatelessWidget {
  const HomePageBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 352,
            child: InkWell(
              onTap: () async {
                String? title = await showHomeDialog(
                  context,
                  'New list',
                  'Enter your list title',
                  'Create list',
                );
                if (!context.mounted) return;
                if (title != null) {
                  Provider.of<TaskListProvider>(context, listen: false)
                      .createTaskList(title);
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
              String? title = await showHomeDialog(
                context,
                'Create a group',
                'Name this group',
                'Create group',
              );
              if (!context.mounted) return;
              if (title != null) {
                Provider.of<GroupProvider>(context, listen: false)
                    .createGroup(title);
              }
            },
            icon: const Icon(
              Icons.post_add,
              color: MyTheme.greyColor,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
