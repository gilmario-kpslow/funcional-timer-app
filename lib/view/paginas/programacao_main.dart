import 'package:cristimer/core/util/mensagem_util.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/paginas/formularios/programacao_list.dart';
import 'package:cristimer/view/paginas/programa_main.dart';
import 'package:cristimer/view/paginas/executar_round.dart';
import 'package:cristimer/core/util/programa_form_service.dart';
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
    print(list.length);
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
    Navigator.pop(context);
    var list = await service.getLista();

    setState(() {
      lista = list;
    });
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
    MensagemUtil.confirmar(
        context, 'Remover Registro', "Remover o Programa ${entity.nome}.",
        () async {
      Navigator.pop(context);
      await service.delete(entity.id);
      _getLista();
    });
  }

  @override
  Widget build(BuildContext context) {
    ProgramacaoList programacoes =
        ProgramacaoList(lista, _remover, _editar, _selecionar);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Rotinas de Treino",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: programacoes,
      floatingActionButton: FloatingActionButton(
        onPressed: _cadastrarProgramacao,
        tooltip: 'Novo programa',
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // persistentFooterButtons: [Text("v1.0.0")],
    );
  }
}
