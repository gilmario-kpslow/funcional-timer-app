import 'package:flutter/material.dart';
import 'package:cristimer/core/util/tempoutil.dart';

class ContadorTempo extends StatelessWidget {
  final int tempo;
  const ContadorTempo({super.key, required this.tempo});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 20, left: 20),
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Text(
          style: const TextStyle(fontSize: 100),
          TempoUtil.format(tempo),
        ));
  }
}
