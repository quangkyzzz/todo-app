// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themes.dart';
import '../../view_models/home_page_group_view_model.dart';
import '../../view_models/home_page_task_list_view_model.dart';
import '../components/show_text_edit_dialog.dart';

class HomePageBottomNavigationBar extends StatelessWidget {
  const HomePageBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Container(
            height: screenHeight * 0.05,
            width: screenWidth * 0.85,
            child: InkWell(
              onTap: () async {
                String? title = await showTextEditDialog(
                  context: context,
                  title: 'New list',
                  hintText: 'Enter your list title',
                  positiveButton: 'Create list',
                );
                if (!context.mounted) return;
                if (title != null) {
                  Provider.of<HomePageTaskListViewModel>(context, listen: false)
                      .createTaskList(name: title);
                }
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
            onPressed: () async {
              String? title = await showTextEditDialog(
                context: context,
                title: 'Create a group',
                hintText: 'Name this group',
                positiveButton: 'Create group',
              );
              if (!context.mounted) return;
              if (title != null) {
                context.read<HomePageGroupViewModel>().createGroup(title);
              }
            },
            icon: const Icon(
              Icons.post_add_outlined,
              color: MyTheme.greyColor,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
