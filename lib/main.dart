import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/settings_provider.dart';
import 'service/background_service.dart';
import 'service/notification_service.dart';
import 'themes.dart';
import 'routes.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await NotificationService.initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyTheme.theme,
          initialRoute: initialRoute,
          routes: allRoute,
        );
      },
    );
  }
}
