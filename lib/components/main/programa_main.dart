import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/formularios/round_form.dart';
import 'package:funcional_timer_app/components/listas/raunds_lista.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';
import 'package:funcional_timer_app/core/modelos/round.dart';
import 'package:funcional_timer_app/core/service/programacao_service.dart';
import 'package:funcional_timer_app/core/service/round_service.dart';

class ProgramaMain extends StatefulWidget {
  final Programacao programacao;
  const ProgramaMain(this.programacao, {super.key});

  @override
  State<StatefulWidget> createState() => _ProgramacaoMainState();
}

class _ProgramacaoMainState extends State<ProgramaMain> {
  ProgramacaoService service = ProgramacaoService();
  RoundService roudeService = RoundService();
  List<Round> lista = List.empty();
  int tempo = 0;

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
    Programacao programacao = widget.programacao;
    round.programacaoId = programacao.id;

    await roudeService.salvar(round);

    var list = await roudeService.getLista(programacao.id);
    var t = list.map((r) => r.tempo).reduce((a, b) => a + b);

    setState(() {
      lista = list;
      tempo = t;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Programacao programacao = widget.programacao;

    SizedBox status = SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Status do programa: ativo",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Número de Rounds: ${lista.length}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Tempo total: $tempo",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );

    RoundList consulta =
        RoundList(lista, (id) {}, (Round entity) {}, (Round entity) {});

    _getLista();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Programa: ${programacao.nome}"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          status,
          consulta,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _cadastrarRound,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
