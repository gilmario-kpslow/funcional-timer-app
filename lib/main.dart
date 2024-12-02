import 'package:cristimer/view/widgets/temas.dart';
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
  var temas = [temaVermelho, temaAzul];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: FuncinalApp.navigatorKey,
      title: 'Funcional APP',
      theme: temas[0],
      home: const HomeMain(),
    );
  }
}
