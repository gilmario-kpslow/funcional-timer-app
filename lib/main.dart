import 'package:flutter/material.dart';
import 'package:cristimer/view/paginas/home_main.dart';

void main() {
  try {
    runApp(const FuncinalApp());
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}

class FuncinalApp extends StatelessWidget {
  const FuncinalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Funcional APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeMain(),
    );
  }
}
