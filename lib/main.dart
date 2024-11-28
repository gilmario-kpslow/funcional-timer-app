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
          primary: Color.fromARGB(255, 9, 85, 185),
          onPrimary: Colors.white,
          secondary: Colors.blue,
          onSecondary: Colors.blue,
          error: Colors.blue,
          onError: Colors.blue,
          surface: Color.fromARGB(255, 255, 255, 255),
          onSurface: Colors.blue,
          onTertiary: Color.fromARGB(255, 9, 85, 185),
          onTertiaryFixedVariant: Color.fromARGB(255, 121, 170, 255),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 9, 85, 185),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 30, color: Colors.white),
            labelLarge: TextStyle(fontSize: 20, color: Colors.blue),
            labelMedium: TextStyle(fontSize: 18, color: Colors.blue),
            displayLarge: TextStyle(fontSize: 30, color: Colors.blue),
            headlineLarge: TextStyle(
                fontSize: 35, color: Colors.blue, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(
                color: Colors.blueAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        buttonTheme: const ButtonThemeData(
            buttonColor: Colors.blueAccent, textTheme: ButtonTextTheme.accent),
        useMaterial3: true,
      ),
      home: const HomeMain(),
    );
  }
}
