import 'package:cristimer/core/util/mensagem_util.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/paginas/formularios/rotinas_list.dart';
import 'package:cristimer/view/paginas/rotina_main.dart';
import 'package:cristimer/view/paginas/executor_rotina.dart';
import 'package:cristimer/core/util/rotina_form_service.dart';
import 'package:cristimer/core/modelos/rotina.dart';
import 'package:cristimer/core/service/rotina_service.dart';

class Rotinas extends StatefulWidget {
  const Rotinas({super.key});

  @override
  State<StatefulWidget> createState() => _RotinasState();
}

class _RotinasState extends State<Rotinas> {
  RotinaService service = RotinaService();
  RotinaFormService formService = RotinaFormService();
  List<Rotina> lista = List.empty();

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

  _cadastrar() async {
    formService.showFormDialog(context, _add, null);
  }

  _add() async {
    Navigator.pop(context);
    var list = await service.getLista();

    setState(() {
      lista = list;
    });
  }

  _editar(Rotina entity) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RotinaMain(entity)));
  }

  _selecionar(Rotina entity) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ExecutorRotina(entity)));
  }

  _remover(Rotina entity) {
    MensagemUtil.confirmar(
        context, 'Remover Registro', "Remover o Rotina \"${entity.nome}\".",
        () async {
      Navigator.pop(context);
      await service.delete(entity.id);
      _getLista();
    });
  }

  @override
  Widget build(BuildContext context) {
    RotinaList programacoes = RotinaList(lista, _remover, _editar, _selecionar);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rotinas de Treino",
        ),
      ),
      body: programacoes,
      floatingActionButton: FloatingActionButton(
        onPressed: _cadastrar,
        tooltip: 'Nova Rotina',
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
