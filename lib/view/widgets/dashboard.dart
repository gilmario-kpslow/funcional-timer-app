import 'package:cristimer/view/paginas/configuracao.dart';
import 'package:cristimer/view/widgets/round_botao.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/paginas/programacao_main.dart';

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
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Text(
          //     "INICIO",
          //     style: Theme.of(context).textTheme.displayLarge,
          //   ),
          // ),
          RoundButton(
            icon: Icons.list,
            nome: "Rotinas de Treino",
            call: () => _navegarProgramas(context),
          ),
          RoundButton(
            icon: Icons.settings,
            nome: "Configuração",
            call: () => _navegarConfiguracao(context),
          ),
        ],
      ),
    );
  }
}
