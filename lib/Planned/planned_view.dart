import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';
import 'package:todo_app/Planned/components/planned_popup_menu.dart';
import 'package:todo_app/Task/components/incomplete_list.dart';

class PlannedView extends StatefulWidget {
  const PlannedView({super.key});

  @override
  State<PlannedView> createState() => _PlannedViewState();
}

class _PlannedViewState extends State<PlannedView> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Planned',
          style: TextStyle(
            fontSize: 40,
            color: AppConfigs.redColor,
          ),
        ),
        actions: const [PlannedPopupMenu()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            //popup menu
            PopupMenuButton(
              offset: const Offset(0, 50),
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                    value: 'Overdue',
                    child: PopupItem(
                      text: 'Overdue',
                      icon: Icons.event_busy_outlined,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Today',
                    child: PopupItem(
                      text: 'Today',
                      icon: Icons.today_outlined,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Tomorrow',
                    child: PopupItem(
                      text: 'Tomorrow',
                      icon: Icons.event_outlined,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'This week',
                    child: PopupItem(
                      text: 'This week',
                      icon: Icons.date_range_outlined,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Later',
                    child: PopupItem(
                      text: 'Later',
                      icon: Icons.calendar_month_outlined,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'All planned',
                    child: PopupItem(
                      text: 'All planned',
                      icon: Icons.event_note_outlined,
                    ),
                  ),
                ];
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppConfigs.backgroundGreyColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.list,
                      size: 30,
                      color: AppConfigs.redColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'All planned',
                      style:
                          TextStyle(fontSize: 20, color: AppConfigs.redColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            //task list
            IncompleteList(taskList: incompleteTask),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppConfigs.blueColor,
        ),
        child: InkWell(
          splashColor: AppConfigs.blackColor,
          customBorder: const CircleBorder(),
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  color: AppConfigs.backgroundGreyColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        shape: const CircleBorder(),
                        value: false,
                        onChanged: (bool? value) {},
                      ),
                      const Expanded(
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Add a task',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.arrow_upward_outlined),
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: Ink(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            height: 70,
            width: 70,
            child: const Icon(
              Icons.add,
              size: 40,
              color: AppConfigs.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
