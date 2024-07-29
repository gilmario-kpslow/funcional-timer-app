import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funcional_timer_app/components/contador_tempo.dart';
import 'package:funcional_timer_app/components/round_botao.dart';

class ExecutarRound extends StatelessWidget {
  const ExecutarRound({super.key});

  @override
  Widget build(BuildContext context) {
    const botoes =
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      RoundButton(
          icon: Icons.published_with_changes_rounded, nome: "Reiniciar"),
      RoundButton(icon: Icons.star_outline, nome: "Favoritar"),
      RoundButton(icon: Icons.settings_suggest, nome: "Configurar"),
    ]);

    final round = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
            style: TextStyle(
                fontSize: 50, color: Colors.blue, fontWeight: FontWeight.bold),
            "1 Round"),
        const ContadorTempo(tempo: 300)
      ],
    );

    final player = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {},
            child: Icon(
              Icons.play_arrow,
              size: 80,
            )),
        TextButton(
            onPressed: () {},
            child: Icon(
              Icons.stop,
              size: 80,
            ))
      ],
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [botoes, round, player],
    );
  }
}
