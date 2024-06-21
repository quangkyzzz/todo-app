import 'package:flutter/material.dart';

class AppConfigs {
  //app theme
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppConfigs.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppConfigs.backgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppConfigs.blueColor,
    ),
  );

  //custom color
  static const Color backgroundColor = Colors.black;
  static const Color backgroundGreyColor = Color.fromARGB(255, 34, 34, 34);
  static const Color searchBarColor = Color.fromRGBO(32, 35, 39, 1);
  static const Color blueColor = Color.fromRGBO(29, 155, 240, 1);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color redColor = Color.fromRGBO(249, 25, 25, 1);
  static const Color blackColor = Colors.black;

  static const Color pinkColor = Color.fromRGBO(202, 113, 153, 1);
  static const Color greenColor = Color.fromRGBO(134, 202, 145, 1);
  static const Color orangeColor = Color.fromRGBO(236, 115, 35, 1);

  //text style
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle secondaryTitleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppConfigs.whiteColor,
  );
  static const TextStyle secondaryTitleGreyTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppConfigs.greyColor,
  );
  static const TextStyle itemTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppConfigs.whiteColor,
  );
  static const TextStyle itemGreyTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppConfigs.greyColor,
  );
  static const TextStyle itemBlackTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppConfigs.blackColor,
  );

  //divider style
  static const Divider dividerGreyStyle = Divider(
    thickness: 0.25,
    color: AppConfigs.greyColor,
  );
  static const Divider dividerWhiteStyle = Divider(
    thickness: 0.25,
    color: AppConfigs.whiteColor,
  );
}
