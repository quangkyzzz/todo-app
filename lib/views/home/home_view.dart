import 'package:flutter/material.dart';
import 'package:todo_app/views/home/home_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.appBar(),
      body: const Text('home'),
    );
  }
}
