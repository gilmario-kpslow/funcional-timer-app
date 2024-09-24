import 'package:flutter/material.dart';
import 'package:cristimer/components/main/home_main.dart';

void main() {
  runApp(const FuncinalApp());
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
