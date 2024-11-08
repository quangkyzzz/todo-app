// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/view_models/group_view_model.dart';
import 'package:todo_app/view_models/user_view_model.dart';

class HomeAppBar {
  BuildContext context;
  HomeAppBar({
    Key? key,
    required this.context,
  });

  AppBar appBar() {
    return AppBar(
      leading: Container(
        padding: const EdgeInsets.only(left: 6),
        child: InkWell(
          onTap: () async {
            await Navigator.of(context).pushNamed(userProfileRoute);
          },
          child: const CircleAvatar(
            backgroundImage: AssetImage(AppConfigs.avatarImage),
            radius: 16.0,
          ),
        ),
      ),
      title: Container(
        width: double.infinity,
        child: InkWell(
          onTap: () async {
            await Navigator.of(context).pushNamed(userProfileRoute);
          },
          child:
              Consumer<UserViewModel>(builder: (context, authViewModel, child) {
            return RichText(
              text: TextSpan(
                text: authViewModel.currentUser.userName,
                style: MyTheme.titleTextStyle,
                children: [
                  TextSpan(
                    text: '\n${authViewModel.currentUser.userEmail}',
                    style: MyTheme.secondaryTitleGreyTextStyle,
                  )
                ],
              ),
            );
          }),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await Navigator.of(context).pushNamed(
              searchRoute,
              arguments: context
                  .read<GroupViewModel>()
                  .groups
                  .firstWhere((element) => element.id == '1')
                  .taskLists
                  .firstWhere((elemment) => elemment.id == '5'),
            );
          },
          icon: const Icon(
            Icons.search,
            size: 42,
            color: MyTheme.greyColor,
          ),
        ),
        const SizedBox(width: 8)
      ],
    );
  }
}
