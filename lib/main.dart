import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/Home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppConfigs.theme,
      home: const HomePage(),
      routes: allRoute,
    );
  }
}
