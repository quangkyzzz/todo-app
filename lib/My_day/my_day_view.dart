// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/My_day/components/my_day_popup_menu.dart';

class MyDayView extends StatefulWidget {
  const MyDayView({super.key});

  @override
  State<MyDayView> createState() => _MyDayViewState();
}

class _MyDayViewState extends State<MyDayView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/backGroundImage.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Container(
              height: 50,
              width: 300,
              child: RichText(
                text: TextSpan(
                    text: 'Quang Nguyen',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text:
                            '\n${DateFormat.MMMMEEEEd('en_US').format(DateTime.now())}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ]),
              ),
            ),
            actions: const [MyDayPopupMenu()],
          ),
          body: SingleChildScrollView(),
        ),
      ],
    );
  }
}
