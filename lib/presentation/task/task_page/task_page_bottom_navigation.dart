import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../service/notification_service.dart';
import '../../../provider/settings_provider.dart';
import '../../../themes.dart';
import '../../../models/task.dart';
import '../../../view_models/task_view_model.dart';
import '../../components/show_alert_dialog.dart';
import 'package:intl/intl.dart';

class TaskPageBottomNavigation extends StatelessWidget {
  final TaskList taskList;
  final Task task;
  const TaskPageBottomNavigation({
    super.key,
    required this.task,
    required this.taskList,
  });

  String diffTimeFormat(Duration diffTime) {
    if (diffTime < const Duration(minutes: 1)) {
      return 'Created a few moments ago';
    } else if (diffTime < const Duration(hours: 1)) {
      return 'Created ${diffTime.inMinutes} minutes ago';
    } else {
      return 'Created ${diffTime.inHours} hours ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    TaskViewModel taskViewModel =
        Provider.of<TaskViewModel>(context, listen: false);
    SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    Duration diffTime = DateTime.now().difference(task.createDate);
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: MyTheme.greyColor,
            width: 0.3,
          ),
        ),
      ),
      child: Row(
        children: [
          (diffTime < const Duration(days: 1))
              ? Text(
                  diffTimeFormat(diffTime),
                  style: MyTheme.itemGreyTextStyle,
                )
              : Text(
                  'Created on ${DateFormat.MMMEd('en_US').format(task.createDate)}',
                  style: MyTheme.itemGreyTextStyle,
                ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              if (settingsProvider.settings.isConfirmBeforeDelete) {
                bool isDelete = await showAlertDialog(
                  context,
                  'Are you sure?',
                  '"${task.title}" will be permanently deleted',
                );
                if (!context.mounted) return;
                if (isDelete) {
                  await NotificationService.cancelNotification(
                      int.parse(task.id));
                  taskViewModel.deleteTask();
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              } else {
                taskViewModel.deleteTask();
                Navigator.pop(context);
              }
            },
            icon: Transform.scale(
              scale: 1.3,
              child: const Icon(
                Icons.delete_outline,
                color: MyTheme.greyColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
