// ignore_for_file: sized_box_for_whitespace
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task_list.dart';
import '../../provider/settings_provider.dart';
import '../../view_models/task_list_view_model.dart';
import 'show_alert_dialog.dart';
import 'show_text_edit_dialog.dart';
import '../../routes.dart';
import '../../themes.dart';
import '../items/popup_item.dart';
import 'change_theme_bottom_sheet.dart';
import 'sort_by_bottom_sheet.dart';

class PopupMenu extends StatelessWidget {
  final TaskList taskList;
  final List<Map<String, dynamic>>? customListPopupMenuItem;
  final List<String> toRemove;
  const PopupMenu({
    super.key,
    required this.taskList,
    this.toRemove = const [],
    this.customListPopupMenuItem,
  });

  void onTapRenameList(BuildContext context, TaskList taskList) async {
    String? newName = await showTextEditDialog(
      context: context,
      title: 'Rename your list',
      hintText: '',
      initText: taskList.listName,
      positiveButton: 'Save',
    );
    if (!context.mounted) return;
    if (newName != null) {
      context.read<TaskListViewModel>().renameList(
            taskListID: taskList.id,
            newName: newName,
          );
    }
  }

  Future<void> onTapSortBy(BuildContext context, TaskList taskList) async {
    double screenHeight = MediaQuery.of(context).size.height;
    await showModalBottomSheet(
      constraints: BoxConstraints(maxHeight: screenHeight * 0.35),
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext _) {
        return SortByBottomSheet(
          mContext: context,
          taskList: taskList,
        );
      },
    );
  }

  Future<void> onTapReorder(BuildContext context, TaskList taskList) async {
    await Navigator.of(context).pushNamed(
      reorderRoute,
      arguments: taskList,
    );
  }

  Future<void> onTapAddShortcut(BuildContext context, TaskList taskList) async {
    await showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return NormalBottomSheet(
          title: 'Add to Home screen?',
          acceptText: 'Add',
          onAccept: () {},
        );
      },
    );
  }

  Future<void> onTapChangeTheme(BuildContext context, TaskList taskList) async {
    await showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext _) {
        return ChangeThemeBottomSheet(
          mContext: context,
          taskList: taskList,
        );
      },
    );
  }

  Future<void> onTapHideCompletedTasks(
      BuildContext context, TaskList taskList) async {
    await showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return NormalBottomSheet(
          title: 'Hide completed tasks?',
          acceptText: 'Yes',
          onAccept: () {},
        );
      },
    );
  }

  Future<void> onTapSendCopy(BuildContext context, TaskList taskList) async {
    await showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return NormalBottomSheet(
          title: 'Send a copy?',
          acceptText: 'Send',
          onAccept: () {},
        );
      },
    );
  }

  Future<void> onTapDuplicateList(
      BuildContext context, TaskList taskList) async {
    await showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext _) {
        return NormalBottomSheet(
          title: 'Duplicate list?',
          acceptText: 'Yes',
          onAccept: () {
            context
                .read<TaskListViewModel>()
                .duplicateTaskList(taskListID: taskList.id);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'List duplicate successful!',
                  style: TextStyle(color: MyTheme.whiteColor),
                ),
                backgroundColor: MyTheme.backgroundGreyColor,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> onTapPrintList(BuildContext context, TaskList taskList) async {
    await showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return NormalBottomSheet(
          title: 'Print list?',
          acceptText: 'Print',
          onAccept: () {},
        );
      },
    );
  }

  void onTapDeleteList(BuildContext context, TaskList taskList) async {
    if (context.read<SettingsProvider>().settings.isConfirmBeforeDelete) {
      bool isDelete = await showAlertDialog(
        context,
        'Are you sure?',
        'This list will be delete',
      );
      if (!context.mounted) return;
      if (isDelete) {
        Navigator.pop(context);
        context.read<TaskListViewModel>().deleteTaskList(taskList: taskList);
      }
    } else {
      Navigator.pop(context);
      context.read<TaskListViewModel>().deleteTaskList(taskList: taskList);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listPopupMenuItem = [
      {
        'value': 'rename_list',
        'text': 'Rename list',
        'icon': Icons.edit_outlined,
        'onTap': onTapRenameList,
      },
      {
        'value': 'sort_by',
        'text': 'Sort by',
        'icon': Icons.sort_outlined,
        'onTap': onTapSortBy,
      },
      {
        'value': 'reorder',
        'text': 'Reorder',
        'icon': Icons.swap_vert,
        'onTap': onTapReorder,
      },
      {
        'value': 'add_shortcut',
        'text': 'Add shortcut',
        'icon': Icons.add_to_home_screen_outlined,
        'onTap': onTapAddShortcut,
      },
      {
        'value': 'change_theme',
        'text': 'Change theme',
        'icon': Icons.palette_outlined,
        'onTap': onTapChangeTheme,
      },
      {
        'value': 'hide_completed_tasks',
        'text': 'Hide completed tasks',
        'icon': Icons.check_circle_outline,
        'onTap': onTapHideCompletedTasks,
      },
      {
        'value': 'send_a_copy',
        'text': 'Send a copy',
        'icon': Icons.share_outlined,
        'onTap': onTapSendCopy,
      },
      {
        'value': 'duplicate_list',
        'text': 'Duplicate list',
        'icon': Icons.copy,
        'onTap': onTapDuplicateList,
      },
      {
        'value': 'print_list',
        'text': 'Print list',
        'icon': Icons.print_outlined,
        'onTap': onTapPrintList,
      },
      {
        'value': 'delete_list',
        'text': 'Delete list',
        'icon': Icons.delete_outline,
        'onTap': onTapDeleteList,
      },
    ];
    (customListPopupMenuItem != null)
        ? listPopupMenuItem = customListPopupMenuItem!
        : true;
    return PopupMenuButton(
      itemBuilder: (_) {
        listPopupMenuItem.removeWhere((element) {
          return toRemove.contains(element['value']);
        });
        return listPopupMenuItem.map((item) {
          return PopupMenuItem(
            value: item['value'],
            onTap: () {
              item['onTap'](context, taskList);
            },
            child: CustomPopupItem(
              text: item['text'],
              icon: item['icon'],
            ),
          );
        }).toList();
      },
    );
  }
}

class NormalBottomSheet extends StatelessWidget {
  final String title;
  final String acceptText;
  final Function() onAccept;
  const NormalBottomSheet({
    super.key,
    required this.title,
    required this.acceptText,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: MyTheme.itemTextStyle,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: MyTheme.itemTextStyle,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: onAccept,
                child: Text(
                  acceptText,
                  style: MyTheme.itemTextStyle,
                ),
              ),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
