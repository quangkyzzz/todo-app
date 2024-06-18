import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';
import 'package:todo_app/Constant/routes.dart';

class TaskListPopupMenu extends StatelessWidget {
  const TaskListPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (context) {
      return [
        PopupMenuItem(
          value: 'sort_by',
          child: PopupItem(
            onTap: () {
              showModalBottomSheet(
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
              Navigator.of(context).pushNamed(reOrderRoute);
            },
          ),
        ),
        PopupMenuItem(
          value: 'add_shortcut',
          child: PopupItem(
            text: 'Add shortcut to homescreen',
            icon: Icons.add_to_home_screen_outlined,
            onTap: () {},
          ),
        ),
        PopupMenuItem(
          value: 'change_theme',
          child: PopupItem(
            text: 'Change theme',
            icon: Icons.palette_outlined,
            onTap: () {},
          ),
        ),
        PopupMenuItem(
          value: 'send_a_copy',
          child: PopupItem(
            text: 'Send a copy',
            icon: Icons.share_outlined,
            onTap: () {},
          ),
        ),
        PopupMenuItem(
          value: 'duplicate_list',
          child: PopupItem(
            text: 'Duplicate list',
            icon: Icons.copy,
            onTap: () {},
          ),
        ),
        PopupMenuItem(
          value: 'print_list ',
          child: PopupItem(
            text: 'Print list',
            icon: Icons.print_outlined,
            onTap: () {},
          ),
        ),
        PopupMenuItem(
          value: 'turn_on_suggestions',
          child: PopupItem(
            text: 'Turn on suggestions',
            icon: Icons.lightbulb_outline,
            onTap: () {},
          ),
        ),
      ];
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
          const SizedBox(width: 10),
          Text(text),
        ]),
      ),
    );
  }
}

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      color: AppConfigs.backgroundGreyColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort by',
            style: TextStyle(fontSize: 25),
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
