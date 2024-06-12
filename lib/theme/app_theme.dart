import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';

class AppTheme {
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
}
