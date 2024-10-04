import 'package:cristimer/core/controllers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/paginas/home_main.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await NotificationController.initializeLocalNotifications();
    await NotificationController.initializeIsolateReceivePort();

    runApp(const FuncinalApp());
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}

class FuncinalApp extends StatefulWidget {
  const FuncinalApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<FuncinalApp> createState() => _FuncinalAppState();
}

class _FuncinalAppState extends State<FuncinalApp> {
  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: FuncinalApp.navigatorKey,
      title: 'Funcional APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeMain(),
    );
  }
}
