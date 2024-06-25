// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/routes.dart';

class PopupMenuComponent extends StatefulWidget {
  final List<String> toRemove;
  const PopupMenuComponent({
    super.key,
    this.toRemove = const [],
  });

  @override
  State<PopupMenuComponent> createState() => _PopupMenuComponentState();
}

class _PopupMenuComponentState extends State<PopupMenuComponent> {
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
  onTapSortBy() {
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

  onTapReorder() {
    Navigator.of(context).pushNamed(reorderRoute);
  }

  onTapAddShortcut() {
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

  onTapChangeTheme() {
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

  onTapHideCompletedTasks() {}

  onTapSendCopy() {
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

  onTapDuplicateList() {
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

  onTapPrintList() {
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

  onTapTurnOnSuggestions() {
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
    List<PopupMenuItem> listPopupItem = [
      for (Map<String, dynamic> item in listPopupMenuItem)
        PopupMenuItem(
          value: item['value'],
          child: PopupItem(
            text: item['text'],
            icon: item['icon'],
            onTap: item['onTap'],
          ),
        )
    ];
    return PopupMenuButton(itemBuilder: (context) {
      listPopupItem.removeWhere((element) {
        return widget.toRemove.contains(element.value);
      });
      return listPopupItem;
    });
  }
}

class PopupItem extends StatelessWidget {
  final Function() onTap;
  final String text;
  final IconData icon;

  const PopupItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        child: Row(children: [
          Icon(icon),
          const SizedBox(width: 15),
          Text(
            text,
            style: AppConfigs.itemSmallTextStyle,
          ),
        ]),
      ),
    );
  }
}

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort by',
            style: AppConfigs.itemTextStyle,
          ),
          const SizedBox(height: 10),
          PopupItem(
            text: 'Important',
            icon: Icons.star_border_outlined,
            onTap: () {},
          ),
          PopupItem(
            text: 'Due date',
            icon: Icons.calendar_today_outlined,
            onTap: () {},
          ),
          PopupItem(
            text: 'Added to My Day',
            icon: Icons.wb_sunny_outlined,
            onTap: () {},
          ),
          PopupItem(
            text: 'Alphabetiaclly',
            icon: Icons.import_export_outlined,
            onTap: () {},
          ),
          PopupItem(
            text: 'Creation date',
            icon: Icons.more_time_outlined,
            onTap: () {},
          ),
        ],
      ),
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
