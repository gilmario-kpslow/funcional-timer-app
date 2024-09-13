import 'package:flutter/material.dart';
import 'package:cristimer/components/listas/programacao_list.dart';
import 'package:cristimer/components/main/programa_main.dart';
import 'package:cristimer/components/outros/executar_round.dart';
import 'package:cristimer/components/outros/programa_form_service.dart';
import 'package:cristimer/core/modelos/programacao.dart';
import 'package:cristimer/core/service/programacao_service.dart';

class ProgramacaoMain extends StatefulWidget {
  const ProgramacaoMain({super.key});

  @override
  State<StatefulWidget> createState() => _ProgramacaoMainState();
}

class _ProgramacaoMainState extends State<ProgramacaoMain> {
  ProgramacaoService service = ProgramacaoService();
  ProgramaFormService formService = ProgramaFormService();
  List<Programacao> lista = List.empty();

  _getLista() async {
    var list = await service.getLista();
    setState(() {
      lista = list;
    });
  }

  @override
  void initState() {
    super.initState();
    _getLista();
  }

  _cadastrarProgramacao() async {
    formService.showFormDialog(context, _addProgramacao, null);
  }

  _addProgramacao() async {
    var list = await service.getLista();

    setState(() {
      lista = list;
    });

    Navigator.pop(context);
  }

  _editar(Programacao entity) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProgramaMain(entity)));
  }

  _selecionar(Programacao entity) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ExecutarRound(entity)));
  }

  _remover(Programacao entity) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Remover Registro"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: [Text("Remover o rograma")],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                service.delete(entity.id);
                _getLista();
                Navigator.pop(context);
              },
              child: const Text("Confirmar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProgramacaoList programacoes =
        ProgramacaoList(lista, _remover, _editar, _selecionar);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Programas de Treino"),
      ),
      body: programacoes,
      floatingActionButton: FloatingActionButton(
        onPressed: _cadastrarProgramacao,
        tooltip: 'Novo programa',
        child: const Icon(Icons.add),
      ),
    );
  }
}
