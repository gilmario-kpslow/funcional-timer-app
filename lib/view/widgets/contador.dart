import 'dart:async';

import 'package:flutter/material.dart';

class Contador extends StatefulWidget {
  final int tempo;
  final Function call;
  const Contador({super.key, required this.tempo, required this.call});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int _tempo = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    _contar();
  }

  _contar() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _tempo += 1;
      });
      if (_tempo >= widget.tempo) {
        widget.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "${widget.tempo - _tempo}",
              style: const TextStyle(fontSize: 80),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}
