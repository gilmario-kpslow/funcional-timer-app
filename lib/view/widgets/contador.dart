import 'dart:async';

import 'package:flutter/material.dart';

class Contador extends StatefulWidget {
  final int tempo;
  final Function call;
  const Contador({super.key, required this.tempo, required this.call});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> with TickerProviderStateMixin {
  int _tempo = 0;
  Timer? timer;
  static const Duration duration = Duration(milliseconds: 500);
  static const Curve curve = Curves.easeIn;

  late final AnimationController _controller = AnimationController(
    duration: duration,
    vsync: this,
  )..repeat(reverse: true);

  late final CurvedAnimation _animation = CurvedAnimation(
    parent: _controller,
    curve: curve,
  );

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
      if (_tempo > widget.tempo) {
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
            padding: const EdgeInsets.all(30.0),
            child: FadeTransition(
              opacity: _animation,
              child: Text(
                "${widget.tempo - _tempo}",
                style: const TextStyle(fontSize: 120),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }
}
