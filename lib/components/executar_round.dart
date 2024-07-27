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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text("1 Round")),
        const ContadorTempo(tempo: 300)
      ],
    );

    final player = Row(
      children: [
        TextButton(onPressed: () {}, child: Icon(Icons.play_arrow)),
        TextButton(onPressed: () {}, child: Icon(Icons.stop))
      ],
    );

    return Column(
      children: [botoes, round, player],
    );
  }
}
