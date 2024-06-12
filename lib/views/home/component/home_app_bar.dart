import 'package:flutter/material.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/views/search/search_view.dart';
import 'package:todo_app/views/user_profile/user_profile_view.dart';

class HomeAppBar {
  BuildContext context;
  HomeAppBar({Key? key, required this.context});

  AppBar appBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.push(context, UserProfileView.route());
        },
        child: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/avatar.jpg'),
          radius: 15.0,
        ),
      ),
      title: Container(
        height: 50,
        width: 300,
        child: InkWell(
          onTap: () {
            Navigator.push(context, UserProfileView.route());
          },
          child: RichText(
            text: const TextSpan(
                text: 'Quang Nguyen',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: '\nquang.ndt@outlook.com',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Pallete.greyColor),
                  )
                ]),
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              SearchView.route(),
            );
          },
          child: const Icon(
            Icons.search,
            size: 40,
            color: Pallete.greyColor,
          ),
        ),
      ],
    );
  }
}
