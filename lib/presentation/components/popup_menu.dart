// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/routes.dart';

import '../items/bottom_sheet_item.dart';
import '../items/popup_item.dart';

class PopupMenu extends StatefulWidget {
  final List<Map<String, dynamic>>? customListPopupMenuItem;
  final List<String> toRemove;
  const PopupMenu({
    super.key,
    this.toRemove = const [],
    this.customListPopupMenuItem,
  });

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  late List<Map<String, dynamic>> listPopupMenuItem = [
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
      'value': 'turn_on_suggestions',
      'text': 'Turn on suggestions',
      'icon': Icons.lightbulb_outline,
      'onTap': onTapTurnOnSuggestions,
    },
  ];
  onTapSortBy(BuildContext context) {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 350),
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const BottomSheetItem();
      },
    );
  }

  onTapReorder(BuildContext context) {
    Navigator.of(context).pushNamed(reorderRoute);
  }

  onTapAddShortcut(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const NormalBottomSheetItem(
          title: 'Add to Home screen?',
          button: 'Add',
        );
      },
    );
  }

  onTapChangeTheme(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const NormalBottomSheetItem(
          title: 'Change theme?',
          button: 'Change',
        );
      },
    );
  }

  onTapHideCompletedTasks(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const NormalBottomSheetItem(
          title: 'Hide completed tasks?',
          button: 'Yes',
        );
      },
    );
  }

  onTapSendCopy(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const NormalBottomSheetItem(
          title: 'Send a copy?',
          button: 'Send',
        );
      },
    );
  }

  onTapDuplicateList(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const NormalBottomSheetItem(
          title: 'Duplicate list?',
          button: 'Yes',
        );
      },
    );
  }

  onTapPrintList(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const NormalBottomSheetItem(
          title: 'Print list?',
          button: 'Print',
        );
      },
    );
  }

  onTapTurnOnSuggestions(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const NormalBottomSheetItem(
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
              item['onTap'](context);
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

class NormalBottomSheetItem extends StatelessWidget {
  final String title;
  final String button;
  const NormalBottomSheetItem({
    super.key,
    required this.title,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  button,
                  style: const TextStyle(fontSize: 20),
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
