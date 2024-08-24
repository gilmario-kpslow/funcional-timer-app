import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/layout/contador_tempo.dart';
import 'package:funcional_timer_app/components/layout/round_botao.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';

class ExecutarRound extends StatelessWidget {
  final Programacao programacao;
  const ExecutarRound(this.programacao, {super.key});

  @override
  Widget build(BuildContext context) {
    const botoes =
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      RoundButton(
          icon: Icons.published_with_changes_rounded, nome: "Reiniciar"),
      RoundButton(icon: Icons.star_outline, nome: "Favoritar"),
      RoundButton(icon: Icons.settings_suggest, nome: "Configurar"),
    ]);

    const round = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
            style: TextStyle(
                fontSize: 50, color: Colors.blue, fontWeight: FontWeight.bold),
            "1 Round"),
        ContadorTempo(tempo: 300)
      ],
    );

    final player = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {},
            child: const Icon(
              Icons.play_arrow,
              size: 80,
            )),
        TextButton(
            onPressed: () {},
            child: const Icon(
              Icons.stop,
              size: 80,
            ))
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(programacao.nome),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [botoes, round, player],
      ),
    );
  }
}
