import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final IconData icon;
  final String nome;
  const RoundButton({super.key, required this.icon, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      IconButton(
        iconSize: 80,
        icon: Icon(icon),
        onPressed: () {},
        color: Theme.of(context).colorScheme.error,
      ),
      Text(nome)
    ]);
  }
}
