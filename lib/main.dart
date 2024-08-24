// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/main/home_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Funcional APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const HomeMain(),
    );
  }
}
