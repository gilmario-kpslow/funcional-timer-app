import 'package:cristimer/view/paginas/configuracao.dart';
import 'package:cristimer/view/components/round_botao.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/paginas/rotinas.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  _navegarRotinas(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const Rotinas()));
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
          RoundButton(
            icon: Icons.list,
            nome: "Rotinas de Treino",
            call: () => _navegarRotinas(context),
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
