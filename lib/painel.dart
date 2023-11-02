import 'package:flutter/material.dart';

class Painel extends StatelessWidget {
  const Painel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
          useMaterial3: true,
        ),
        home: const Text("TESTE"));
  }
}
