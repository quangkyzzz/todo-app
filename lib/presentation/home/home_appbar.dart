// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_configs.dart';
import '../../routes.dart';
import '../../themes.dart';
import '../../view_models/home_page_view_model.dart';

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
          child: Consumer<HomePageViewModel>(
              builder: (context, homePageViewModel, child) {
            return RichText(
              text: TextSpan(
                text: homePageViewModel.currentUser.userName,
                style: MyTheme.titleTextStyle,
                children: [
                  TextSpan(
                    text: '\n${homePageViewModel.currentUser.userEmail}',
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
            await Navigator.of(context).pushNamed(searchRoute);
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
