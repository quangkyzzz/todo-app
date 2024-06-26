import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';

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
      theme: MyTheme.theme,
      initialRoute: initialRoute,
      routes: allRoute,
    );
  }
}
