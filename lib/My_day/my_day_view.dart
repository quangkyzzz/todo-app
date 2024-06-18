// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Constant/app_configs.dart';
import 'package:todo_app/My_day/components/my_day_popup_menu.dart';
import 'package:todo_app/Task/components/incomplete_list.dart';

class MyDayView extends StatefulWidget {
  const MyDayView({super.key});

  @override
  State<MyDayView> createState() => _MyDayViewState();
}

class _MyDayViewState extends State<MyDayView> {
  bool isExpanded = true;
  List<Map<String, dynamic>> incompleteTask = [
    {
      'taskID': '1',
      'title': 'task 1',
      'isCompleted': false,
      'note': 'xdd',
      'filePath': 'xdd'
    },
    {
      'taskID': '2',
      'title': 'task 2',
      'isCompleted': false,
      'dueDate': DateTime.now(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/backGroundImage.jpg',
          fit: BoxFit.fitHeight,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Container(
              height: 50,
              width: 300,
              child: RichText(
                text: TextSpan(
                    text: 'My Day',
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
          body: SingleChildScrollView(
            child: Column(children: [
              IncompleteList(taskList: incompleteTask),
              ExpansionTile(
                initiallyExpanded: true,
                title: const Text(
                  'Completed',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppConfigs.blueColor,
                  ),
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    isExpanded = expanded;
                  });
                },
                trailing: Icon(
                    isExpanded ? Icons.expand_more : Icons.keyboard_arrow_left),
                children: [
                  IncompleteList(
                    taskList: incompleteTask,
                  ),
                ],
              )
            ]),
          ),
          floatingActionButton: Row(
            children: [
              const Spacer(flex: 2),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: AppConfigs.blueColor,
                ),
                child: InkWell(
                  splashColor: AppConfigs.blackColor,
                  customBorder: const CircleBorder(),
                  onTap: () {},
                  child: Ink(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Text(
                      'Suggestions',
                      style:
                          TextStyle(color: AppConfigs.blackColor, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppConfigs.blueColor,
                ),
                child: InkWell(
                  splashColor: AppConfigs.blackColor,
                  customBorder: const CircleBorder(),
                  onTap: () {},
                  child: Ink(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    height: 60,
                    width: 60,
                    child: const Icon(
                      Icons.add,
                      size: 40,
                      color: AppConfigs.blackColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
