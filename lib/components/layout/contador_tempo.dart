import 'package:flutter/material.dart';

class ContadorTempo extends StatelessWidget {
  final int tempo;
  const ContadorTempo({super.key, required this.tempo});

  @override
  Widget build(BuildContext context) {
    return Text(style: const TextStyle(fontSize: 100), "$tempo");
  }
}
