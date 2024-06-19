import 'package:flutter/material.dart';

class ReOrderView extends StatefulWidget {
  const ReOrderView({super.key});

  @override
  State<ReOrderView> createState() => _ReOrderViewState();
}

class _ReOrderViewState extends State<ReOrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reorder tasks'),
      ),
    );
  }
}
