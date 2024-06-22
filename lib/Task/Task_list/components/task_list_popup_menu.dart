// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/constant/app_configs.dart';
import 'package:todo_app/constant/routes.dart';

class TaskListPopupMenu extends StatelessWidget {
  final List<String> toRemove;
  const TaskListPopupMenu({
    super.key,
    this.toRemove = const [],
  });

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem> listPopupItem = [
      PopupMenuItem(
        value: 'sort_by',
        child: PopupItem(
          onTap: () {
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
          },
          text: 'Sort by',
          icon: Icons.sort_outlined,
        ),
      ),
      PopupMenuItem(
        value: 'reorder',
        child: PopupItem(
          text: 'Reorder',
          icon: Icons.swap_vert,
          onTap: () {
            Navigator.of(context).pushNamed(reorderRoute);
          },
        ),
      ),
      PopupMenuItem(
        value: 'add_shortcut',
        child: PopupItem(
          text: 'Add shortcut',
          icon: Icons.add_to_home_screen_outlined,
          onTap: () {
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
          },
        ),
      ),
      PopupMenuItem(
        value: 'change_theme',
        child: PopupItem(
          text: 'Change theme',
          icon: Icons.palette_outlined,
          onTap: () {
            showModalBottomSheet(
              isDismissible: true,
              enableDrag: true,
              context: context,
              showDragHandle: true,
              builder: (BuildContext context) {
                return const NormalBottomSheetItem(
                  title: 'Pick a theme?',
                  button: 'Pick',
                );
              },
            );
          },
        ),
      ),
      PopupMenuItem(
        value: 'hide_completed_tasks',
        child: PopupItem(
          text: 'Hide completed tasks',
          icon: Icons.check_circle_outline,
          onTap: () {},
        ),
      ),
      PopupMenuItem(
        value: 'send_a_copy',
        child: PopupItem(
          text: 'Send a copy',
          icon: Icons.share_outlined,
          onTap: () {
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
          },
        ),
      ),
      PopupMenuItem(
        value: 'duplicate_list',
        child: PopupItem(
          text: 'Duplicate list',
          icon: Icons.copy,
          onTap: () {
            showModalBottomSheet(
              isDismissible: true,
              enableDrag: true,
              context: context,
              showDragHandle: true,
              builder: (BuildContext context) {
                return const NormalBottomSheetItem(
                  title: 'Duplicate this list?',
                  button: 'Duplicate',
                );
              },
            );
          },
        ),
      ),
      PopupMenuItem(
        value: 'print_list',
        child: PopupItem(
          text: 'Print list',
          icon: Icons.print_outlined,
          onTap: () {
            showModalBottomSheet(
              isDismissible: true,
              enableDrag: true,
              context: context,
              showDragHandle: true,
              builder: (BuildContext context) {
                return const NormalBottomSheetItem(
                  title: 'Print this list?',
                  button: 'Print',
                );
              },
            );
          },
        ),
      ),
      PopupMenuItem(
        value: 'turn_on_suggestions',
        child: PopupItem(
          text: 'Turn on suggestions',
          icon: Icons.lightbulb_outline,
          onTap: () {
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
          },
        ),
      ),
    ];
    return PopupMenuButton(itemBuilder: (context) {
      listPopupItem.removeWhere((element) {
        return toRemove.contains(element.value);
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
            style: AppConfigs.itemTextStyle,
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
    return Column(
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
