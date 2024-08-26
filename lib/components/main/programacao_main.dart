import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/formularios/programacao_form.dart';
import 'package:funcional_timer_app/components/listas/programacao_list.dart';
import 'package:funcional_timer_app/components/main/programa_main.dart';
import 'package:funcional_timer_app/components/outros/executar_round.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';
import 'package:funcional_timer_app/core/service/programacao_service.dart';

class ProgramacaoMain extends StatefulWidget {
  const ProgramacaoMain({super.key});

  @override
  State<StatefulWidget> createState() => _ProgramacaoMainState();
}

class _ProgramacaoMainState extends State<ProgramacaoMain> {
  ProgramacaoService service = ProgramacaoService();
  List<Programacao> lista = List.empty();

  _getLista() async {
    var list = await service.getLista();
    setState(() {
      lista = list;
    });
  }

  _cadastrarProgramacao() async {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (ctx) {
          return ProgramacaoForm(_addProgramacao);
        });
  }

  _addProgramacao(String descricao, String nome) async {
    final p = Programacao.basico(nome, descricao);
    await service.salvar(p);
    var list = await service.getLista();

    setState(() {
      lista = list;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ProgramacaoList programacoes =
        ProgramacaoList(lista, (id) {}, (Programacao entity) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProgramaMain(entity)),
      );
    }, (Programacao entity) {
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
      body: programacoes,
      floatingActionButton: FloatingActionButton(
        onPressed: _cadastrarProgramacao,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
