import 'package:flutter/material.dart';
import 'package:cristimer/view/paginas/home_main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FuncinalApp());
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: FuncinalApp.navigatorKey,
      title: 'Funcional APP',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 192, 30, 0),
          onPrimary: Colors.white,
          secondary: Colors.red,
          onSecondary: Colors.red,
          error: Colors.red,
          onError: Colors.red,
          surface: Color.fromARGB(255, 255, 255, 255),
          onSurface: Colors.red,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 192, 30, 0),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 30, color: Colors.white),
            labelLarge: TextStyle(fontSize: 20, color: Colors.red),
            labelMedium: TextStyle(fontSize: 18, color: Colors.red),
            displayLarge: TextStyle(fontSize: 30, color: Colors.red),
            displayMedium: TextStyle(
                color: Colors.redAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        buttonTheme: const ButtonThemeData(
            buttonColor: Colors.redAccent, textTheme: ButtonTextTheme.accent),
        useMaterial3: true,
      ),
      home: const HomeMain(),
    );
  }
}
