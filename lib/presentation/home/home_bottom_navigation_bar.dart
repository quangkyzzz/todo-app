// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data_source/settings_shared_preference.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/view_models/group_view_model.dart';
import 'package:todo_app/presentation/components/show_text_edit_dialog.dart';

class HomePageBottomNavigationBar extends StatelessWidget {
  const HomePageBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SettingsSharedPreference settingsSharedPreference =
        SettingsSharedPreference.getInstance;
    settingsSharedPreference.toString();
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
                  Provider.of<GroupViewModel>(context, listen: false)
                      .createNewTaskListToDefaultGroup(name: title);
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
                context.read<GroupViewModel>().createGroup(title);
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
