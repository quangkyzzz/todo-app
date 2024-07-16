// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';
import 'home_dialog.dart';

class HomePageBottomNavigationBar extends StatelessWidget {
  const HomePageBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 352,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return HomeDialog(
                      title: 'New List',
                      hintText: 'Enter your list title',
                      positiveButton: 'Create list',
                      onTap: () {},
                    );
                  },
                );
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: MyTheme.greyColor,
                    size: 30,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'New list',
                    style: MyTheme.itemGreyTextStyle,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return HomeDialog(
                      title: 'Create a group',
                      hintText: 'Name this group',
                      positiveButton: 'Create group',
                      onTap: () {},
                    );
                  });
            },
            icon: const Icon(
              Icons.post_add,
              color: MyTheme.greyColor,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
