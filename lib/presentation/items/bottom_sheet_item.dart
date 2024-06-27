// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/presentation/items/popup_item.dart';
import 'package:todo_app/themes.dart';

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({super.key});

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
