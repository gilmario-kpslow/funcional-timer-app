import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final IconData icon;
  final String nome;
  final Function call;
  const RoundButton(
      {super.key, required this.icon, required this.nome, required this.call});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      IconButton(
        iconSize: 80,
        icon: Icon(icon),
        onPressed: () {
          call();
        },
        color: Theme.of(context).colorScheme.error,
      ),
      Text(
          style:
              const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          nome)
    ]);
  }
}
