import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/formularios/round_form.dart';
import 'package:funcional_timer_app/components/outros/executar_round.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';
import 'package:funcional_timer_app/core/modelos/round.dart';
import 'package:funcional_timer_app/core/service/programacao_service.dart';
import 'package:funcional_timer_app/core/service/round_service.dart';

class ProgramacaoMain extends StatefulWidget {
  const ProgramacaoMain({super.key});

  @override
  State<StatefulWidget> createState() => _ProgramacaoMainState();
}

class _ProgramacaoMainState extends State<ProgramacaoMain> {
  ProgramacaoService service = ProgramacaoService();
  RoundService roudeService = RoundService();
  List<Round> lista = List.empty();

  _getLista() async {
    var list = await roudeService.getLista(0);
    setState(() {
      lista = list;
    });
  }

  _cadastrarRound() async {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (ctx) {
          return RoundForm(_addRound);
        });
  }

  _addRound(Round round) async {
    await roudeService.salvar(round);
    var list = await roudeService.getLista();

    setState(() {
      lista = list;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    RoundLista consulta = RoundLista(lista, (id) {}, (Programacao entity) {},
        (Programacao entity) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ExecutarRound(entity)),
      );
    });

    _getLista();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Programas de Treino"),
      ),
      body: consulta,
      floatingActionButton: FloatingActionButton(
        onPressed: _cadastrarRound,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
