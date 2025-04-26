import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final IconData icon;
  final String nome;
  final Function call;
  const RoundButton(
      {super.key, required this.icon, required this.nome, required this.call});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        IconButton(
          iconSize: 80,
          icon: Icon(icon),
          onPressed: () {
            call();
          },
          color: Colors.redAccent,
        ),
        Text(style: Theme.of(context).textTheme.labelLarge, nome)
      ]),
    );
  }
}
