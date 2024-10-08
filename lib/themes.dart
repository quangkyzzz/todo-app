import 'package:flutter/material.dart';

class MyTheme {
  //app theme
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: MyTheme.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: MyTheme.backgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: MyTheme.blueColor,
    ),
  );

  //custom color
  static const Color backgroundColor = Colors.black;
  static const Color backgroundGreyColor = Color.fromARGB(255, 34, 34, 34);
  static const Color searchBarColor = Color.fromRGBO(32, 35, 39, 1);
  static const Color blueColor = Color.fromRGBO(29, 155, 240, 1);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color dardGreyColor = Color.fromARGB(255, 97, 96, 96);
  static const Color redColor = Color.fromRGBO(249, 25, 25, 1);
  static const Color blackColor = Colors.black;
  static const Color pinkColor = Color.fromRGBO(202, 113, 153, 1);
  static const Color greenColor = Color.fromRGBO(134, 202, 145, 1);
  static const Color orangeColor = Color.fromRGBO(236, 115, 35, 1);
  static const Color yellowColor = Color.fromRGBO(231, 197, 45, 1);
  static const Color darkGreenColor = Color.fromRGBO(23, 131, 41, 1);
  static const Color lightBlueColor = Color.fromRGBO(35, 236, 219, 1);
  static const Color lightGreyColor = Color.fromRGBO(102, 104, 104, 1);
  static const Color darkBlueColor = Color.fromRGBO(35, 72, 236, 1);
  static const Color blackPinkColor = Color.fromRGBO(143, 12, 88, 1);

  //TaksList theme color
  static const List<Color> colorThemeList = [
    whiteColor,
    blueColor,
    redColor,
    pinkColor,
    greenColor,
    orangeColor,
    yellowColor,
    darkGreenColor,
    lightBlueColor,
    darkBlueColor,
    blackPinkColor,
  ];

  //Tasklist default image
  static List<String> imageList = [
    'assets/backgrounds/bg_my_day.jpg',
    'assets/backgrounds/bg_default_1.png',
    'assets/backgrounds/bg_default_2.jpg',
    'assets/backgrounds/bg_default_3.jpg',
    'assets/backgrounds/bg_default_4.jpg',
    'assets/backgrounds/bg_default_5.jpg',
    'assets/backgrounds/bg_default_6.jpg',
  ];

  //text style
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle secondaryTitleTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyTheme.whiteColor,
  );
  static const TextStyle secondaryTitleGreyTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyTheme.greyColor,
  );
  static const TextStyle itemTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: MyTheme.whiteColor,
  );
  static const TextStyle itemDeleteTextStyle = TextStyle(
    decoration: TextDecoration.lineThrough,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: MyTheme.greyColor,
  );
  static const TextStyle itemGreyTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: MyTheme.greyColor,
  );
  static const TextStyle itemBlackTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: MyTheme.blackColor,
  );
  static const TextStyle itemBlackSmallTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyTheme.blackColor,
  );
  static const TextStyle itemSmallTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyTheme.whiteColor,
  );
  static const TextStyle itemSmallGreyTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyTheme.greyColor,
  );
  static const TextStyle itemExtraSmallBlackTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: MyTheme.blackColor,
  );
  static const TextStyle itemExtraSmallTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: MyTheme.whiteColor,
  );
  static const TextStyle itemExtraSmallGreyTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: MyTheme.greyColor,
  );
  static const TextStyle itemExtraSmallRedTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: MyTheme.redColor,
  );

  //divider style
  static const Divider dividerGreyStyle = Divider(
    thickness: 0.25,
    color: MyTheme.greyColor,
  );
  static const Divider dividerWhiteStyle = Divider(
    thickness: 0.25,
    color: MyTheme.whiteColor,
  );
}
