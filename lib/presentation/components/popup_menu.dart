// ignore_for_file: sized_box_for_whitespace
import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task_list_model.dart';
import 'show_alert_dialog.dart';
import 'show_text_edit_dialog.dart';
import '../../provider/group_provider.dart';
import '../../provider/settings_provider.dart';
import '../../provider/task_list_provider.dart';
import '../../routes.dart';
import '../../themes.dart';
import '../items/popup_item.dart';
import 'change_theme_bottom_sheet.dart';
import 'sort_by_bottom_sheet.dart';

class PopupMenu extends StatefulWidget {
  final TaskListModel taskList;
  final List<Map<String, dynamic>>? customListPopupMenuItem;
  final List<String> toRemove;

  const PopupMenu({
    super.key,
    required this.taskList,
    this.toRemove = const [],
    this.customListPopupMenuItem,
  });

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

Future<String> longTask() async {
  return await Future.delayed(const Duration(seconds: 3), () => 'result!');
}

class _PopupMenuState extends State<PopupMenu> {
  late GroupProvider groupProvider;
  late TaskListProvider taskListProvider;
  late SettingsProvider settingsProvider;
  late List<Map<String, dynamic>> listPopupMenuItem = [
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

  void onTapRenameList(BuildContext context, String id) async {
    String? newName = await showTextEditDialog(
      context: context,
      title: 'Rename your list',
      hintText: '',
      initText: widget.taskList.listName,
      positiveButton: 'Save',
    );
    if (!mounted) return;
    if (newName != null) {
      taskListProvider.renameList(taskListID: id, newName: newName);
    }
  }

  Future<void> onTapSortBy(BuildContext context, String id) async {
    double screenHeight = MediaQuery.of(context).size.height;
    await showModalBottomSheet(
      constraints: BoxConstraints(maxHeight: screenHeight * 0.35),
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return SortByBottomSheet(
          taskList: widget.taskList,
        );
      },
    );
  }

  Future<void> onTapReorder(BuildContext context, String id) async {
    await Navigator.of(context).pushNamed(
      reorderRoute,
      arguments: widget.taskList,
    );
  }

  Future<void> onTapAddShortcut(BuildContext context, String id) async {
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

  Future<void> onTapChangeTheme(BuildContext context, String id) async {
    await showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return ChangeThemeBottomSheet(taskList: widget.taskList);
      },
    );
  }

  Future<void> onTapHideCompletedTasks(BuildContext context, String id) async {
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

  Future<void> onTapSendCopy(BuildContext context, String id) async {
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

  Future<void> onTapDuplicateList(BuildContext context, String id) async {
    await showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return NormalBottomSheet(
          title: 'Duplicate list?',
          acceptText: 'Yes',
          onAccept: () {
            taskListProvider.duplicateTaskList(taskListID: widget.taskList.id);
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

  Future<void> onTapPrintList(BuildContext context, String id) async {
    await showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return NormalBottomSheet(
          title: 'Print list?',
          acceptText: 'Print',
          onAccept: () async {
            final result = await Isolate.run(longTask);
            print(result);
          },
        );
      },
    );
  }

  void onTapDeleteList(BuildContext context, String id) async {
    if (settingsProvider.settings.isConfirmBeforeDelete) {
      bool isDelete = await showAlertDialog(
        context,
        'Are you sure?',
        'This list will be delete',
      );
      if (!mounted) return;
      if (isDelete) {
        Navigator.pop(context);
        if (widget.taskList.groupID != null) {
          groupProvider.deleteTaskListByID(
            groupID: widget.taskList.groupID!,
            taskListID: widget.taskList.id,
          );
        }
        taskListProvider.deleteTaskList(id: id);
      }
    } else {
      Navigator.pop(context);
      if (widget.taskList.groupID != null) {
        groupProvider.deleteTaskListByID(
          groupID: widget.taskList.groupID!,
          taskListID: widget.taskList.id,
        );
      }
      taskListProvider.deleteTaskList(id: id);
    }
  }

  @override
  void initState() {
    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    groupProvider = Provider.of<GroupProvider>(context, listen: false);
    settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    (widget.customListPopupMenuItem != null)
        ? listPopupMenuItem = widget.customListPopupMenuItem!
        : true;
    return PopupMenuButton(
      itemBuilder: (context) {
        listPopupMenuItem.removeWhere((element) {
          return widget.toRemove.contains(element['value']);
        });
        return listPopupMenuItem.map((item) {
          return PopupMenuItem(
            value: item['value'],
            onTap: () {
              item['onTap'](context, widget.taskList.id);
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
