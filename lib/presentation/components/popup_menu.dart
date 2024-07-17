// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/presentation/components/show_alert_dialog.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/items/popup_item.dart';

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
  late List<Map<String, dynamic>> listPopupMenuItem = [
    {
      'value': 'rename_list',
      'text': 'Rename list',
      'icon': Icons.edit_outlined,
      'onTap': onTapDeleteList,
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
    Navigator.of(context).pushNamed(reorderRoute);
  }

  onTapAddShortcut(BuildContext context, String id) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const NormalBottomSheet(
          title: 'Add to Home screen?',
          button: 'Add',
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
        return const ChangeThemeBottomSheet();
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
        return const NormalBottomSheet(
          title: 'Hide completed tasks?',
          button: 'Yes',
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
        return const NormalBottomSheet(
          title: 'Send a copy?',
          button: 'Send',
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
        return const NormalBottomSheet(
          title: 'Duplicate list?',
          button: 'Yes',
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
        return const NormalBottomSheet(
          title: 'Print list?',
          button: 'Print',
        );
      },
    );
  }

  onTapDeleteList(BuildContext context, String id) async {
    bool isDelete = await showAlertDialog(
      context,
      'Are you sure?',
      'This list will be delete',
    );
    if (!mounted) return;
    if (isDelete) {
      Provider.of<TaskListProvider>(context, listen: false).deleteTaskList(id);
      Navigator.pop(context);
    }
  }

  onTapTurnOnSuggestions(BuildContext context, String id) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const NormalBottomSheet(
          title: 'Turn on suggestions?',
          button: 'Turn on',
        );
      },
    );
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
  final String button;
  const NormalBottomSheet({
    super.key,
    required this.title,
    required this.button,
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
                onPressed: () {},
                child: Text(
                  button,
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
              text: 'Alphabetiaclly',
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

class ChangeThemeBottomSheet extends StatefulWidget {
  const ChangeThemeBottomSheet({super.key});

  @override
  State<ChangeThemeBottomSheet> createState() => _ChangeThemeBottomSheetState();
}

class _ChangeThemeBottomSheetState extends State<ChangeThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pick a theme',
              style: MyTheme.itemTextStyle,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: MyTheme.redColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
