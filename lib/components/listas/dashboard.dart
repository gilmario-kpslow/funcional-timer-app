import 'package:cristimer/components/outros/configuracao.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/components/main/programacao_main.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  _navegarProgramas(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const ProgramacaoMain()));
  }

  _navegarConfiguracao(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const Configuracao()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Menu inicial",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          ],
        ),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: ElevatedButton(
                onPressed: () => _navegarConfiguracao(context),
                child: const Text("Configurações"),
              ),
            ),
            Flexible(
                fit: FlexFit.tight,
                child: ElevatedButton(
                    onPressed: () => _navegarProgramas(context),
                    child: const Text("Programas de Treino"))),
          ],
        ),
      ],
    );
  }
}
