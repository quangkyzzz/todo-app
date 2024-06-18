import 'package:flutter/material.dart';

class MyDayPopupMenu extends StatelessWidget {
  const MyDayPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (context) {
      return const [
        PopupMenuItem(
          value: 'sort_by',
          child: PopupItem(
            text: 'Sort by',
            icon: Icons.sort_outlined,
          ),
        ),
        // PopupMenuItem(
        //   value: 'reorder',
        //   child: PopupItem(
        //     text: 'Reorder',
        //     icon: Icons.swap_vert,
        //   ),
        // ),
        PopupMenuItem(
          value: 'add_shortcut',
          child: PopupItem(
            text: 'Add shortcut to homescreen',
            icon: Icons.add_to_home_screen_outlined,
          ),
        ),
        PopupMenuItem(
          value: 'change_theme',
          child: PopupItem(
            text: 'Change theme',
            icon: Icons.palette_outlined,
          ),
        ),
        // PopupMenuItem(
        //   value: 'hide_completed_tasks',
        //   child: PopupItem(
        //     text: 'Hide completed tasks',
        //     icon: Icons.check_circle_outline,
        //   ),
        // ),
        PopupMenuItem(
          value: 'send_a_copy',
          child: PopupItem(
            text: 'Send a copy',
            icon: Icons.share_outlined,
          ),
        ),
        // PopupMenuItem(
        //   value: 'duplicate_list',
        //   child: PopupItem(
        //     text: 'Duplicate list',
        //     icon: Icons.copy,
        //   ),
        // ),
        PopupMenuItem(
          value: 'print_list ',
          child: PopupItem(
            text: 'Print list',
            icon: Icons.print_outlined,
          ),
        ),
        // PopupMenuItem(
        //   value: 'turn_on_suggestions',
        //   child: PopupItem(
        //     text: 'Turn on suggestions',
        //     icon: Icons.lightbulb_outline,
        //   ),
        // ),
      ];
    });
  }
}

class PopupItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const PopupItem({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon),
      const SizedBox(width: 10),
      InkWell(child: Text(text)),
    ]);
  }
}
