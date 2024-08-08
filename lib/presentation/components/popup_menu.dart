// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/presentation/components/show_alert_dialog.dart';
import 'package:todo_app/presentation/components/show_text_edit_dialog.dart';
import 'package:todo_app/provider/group_provider.dart';
import 'package:todo_app/provider/settings_provider.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/items/popup_item.dart';

import 'change_theme_bottom_sheet.dart';

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
    {
      'value': 'turn_on_suggestions',
      'text': 'Turn on suggestions',
      'icon': Icons.lightbulb_outline,
      'onTap': onTapTurnOnSuggestions,
    },
  ];

  onTapRenameList(BuildContext context, String id) async {
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

  onTapSortBy(BuildContext context, String id) {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 350),
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const SortByBottomSheet();
      },
    );
  }

  onTapReorder(BuildContext context, String id) {
    Navigator.of(context).pushNamed(
      reorderRoute,
      arguments: widget.taskList,
    );
  }

  onTapAddShortcut(BuildContext context, String id) {
    showModalBottomSheet(
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

  onTapChangeTheme(BuildContext context, String id) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return ChangeThemeBottomSheet(taskList: widget.taskList);
      },
    );
  }

  onTapHideCompletedTasks(BuildContext context, String id) {
    showModalBottomSheet(
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

  onTapSendCopy(BuildContext context, String id) {
    showModalBottomSheet(
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

  onTapDuplicateList(BuildContext context, String id) {
    showModalBottomSheet(
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
          },
        );
      },
    );
  }

  onTapPrintList(BuildContext context, String id) {
    showModalBottomSheet(
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

  onTapDeleteList(BuildContext context, String id) async {
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

  onTapTurnOnSuggestions(BuildContext context, String id) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return NormalBottomSheet(
          title: 'Turn on suggestions?',
          acceptText: 'Turn on',
          onAccept: () {},
        );
      },
    );
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
            child: PopupItem(
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

class SortByBottomSheet extends StatelessWidget {
  const SortByBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort by',
            style: MyTheme.itemTextStyle,
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {},
            child: const PopupItem(
              text: 'Important',
              icon: Icons.star_border_outlined,
            ),
          ),
          InkWell(
            onTap: () {},
            child: const PopupItem(
              text: 'Due date',
              icon: Icons.calendar_today_outlined,
            ),
          ),
          InkWell(
            onTap: () {},
            child: const PopupItem(
              text: 'Added to My Day',
              icon: Icons.wb_sunny_outlined,
            ),
          ),
          InkWell(
            onTap: () {},
            child: const PopupItem(
              text: 'Alphabetically',
              icon: Icons.import_export_outlined,
            ),
          ),
          InkWell(
            onTap: () {},
            child: const PopupItem(
              text: 'Creation date',
              icon: Icons.more_time_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
