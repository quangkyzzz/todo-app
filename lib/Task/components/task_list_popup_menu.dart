import 'package:flutter/material.dart';

class TaskListPopupMenu extends StatelessWidget {
  const TaskListPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (context) {
      return [
        PopupMenuItem(
          value: 'sort_by',
          child: PopupItem(
            onTap: () {},
            text: 'Sort by',
            icon: Icons.sort_outlined,
          ),
        ),
        PopupMenuItem(
          value: 'reorder',
          child: PopupItem(
            text: 'Reorder',
            icon: Icons.swap_vert,
            onTap: () {},
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
  final Function onTap;
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
    return Row(children: [
      Icon(icon),
      const SizedBox(width: 10),
      InkWell(onTap: onTap(), child: Text(text)),
    ]);
  }
}
