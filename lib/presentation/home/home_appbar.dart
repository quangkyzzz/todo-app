// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/themes.dart';

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
          onTap: () {
            Navigator.of(context).pushNamed(userProfileRoute);
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
          onTap: () {
            Navigator.of(context).pushNamed(userProfileRoute);
          },
          child:
              Consumer<UserProvider>(builder: (context, userProvider, child) {
            return RichText(
              text: TextSpan(
                text: userProvider.currentUser.userName,
                style: MyTheme.titleTextStyle,
                children: [
                  TextSpan(
                    text: '\n${userProvider.currentUser.userEmail}',
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
          onPressed: () {
            Navigator.of(context).pushNamed(searchRoute);
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
