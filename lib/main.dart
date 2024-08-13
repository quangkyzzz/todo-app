import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/notification_service.dart';
import 'package:todo_app/provider/group_provider.dart';
import 'package:todo_app/provider/settings_provider.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    NotificationService.showLocalNotification(
      id: 1,
      title: 'title',
      body: 'test background',
      isPlaySound: true,
    );
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await NotificationService.initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProxyProvider<SettingsProvider, TaskListProvider>(
          create: (context) => TaskListProvider(
              settingsProvider: context.read<SettingsProvider>()),
          update: (context, settingsProvider, taskListProvider) =>
              taskListProvider ??
              TaskListProvider(settingsProvider: settingsProvider),
        ),
        ChangeNotifierProxyProvider<TaskListProvider, GroupProvider>(
            create: (context) =>
                GroupProvider(context.read<TaskListProvider>()),
            update: (context, taskListProvider, groupProvider) =>
                groupProvider ?? GroupProvider(taskListProvider))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.theme,
        initialRoute: initialRoute,
        routes: allRoute,
      ),
    );
  }
}
