import 'package:cristimer/core/util/mensagem_util.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/paginas/formularios/exercicio_form.dart';
import 'package:cristimer/view/widgets/status_rotina.dart';
import 'package:cristimer/view/paginas/formularios/exercicios_lista.dart';
import 'package:cristimer/core/util/rotina_form_service.dart';
import 'package:cristimer/core/modelos/rotina.dart';
import 'package:cristimer/core/modelos/exercicio.dart';
import 'package:cristimer/core/service/rotina_service.dart';
import 'package:cristimer/core/service/exercicio_service.dart';
import 'package:cristimer/core/util/tempoutil.dart';

class RotinaMain extends StatefulWidget {
  final Rotina rotina;
  const RotinaMain(this.rotina, {super.key});

  @override
  State<StatefulWidget> createState() => _RotinaMainState();
}

class _RotinaMainState extends State<RotinaMain> {
  RotinaService service = RotinaService();
  ExercicioService exercicioService = ExercicioService();
  List<Exercicio> lista = List.empty();
  String tempo = "";
  int selectedIndex = 0;
  RotinaFormService formService = RotinaFormService();
  Rotina? rotina;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    setState(() {
      rotina = widget.rotina;
    });
    _getLista();
  }

  _editar() async {
    formService.showFormDialog(context, _add, widget.rotina);
  }

  _add() async {
    Navigator.pop(context);
    var p = await service.get(rotina?.id);

    setState(() {
      rotina = p;
    });
  }

  _getLista() async {
    var list = await exercicioService.getLista(rotina?.id);

    var t = list.isEmpty ? 0 : list.map((r) => r.tempo).reduce((a, b) => a + b);

    setState(() {
      lista = list;
      tempo = TempoUtil.format(t);
    });
  }

  _seleciona(Exercicio exercicio) {}

  _cadastrar(Exercicio? exercicio) async {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return ExercicioForm(_addExercicio, exercicio);
        });
  }

  _cadastrarPausa() async {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return ExercicioForm.pausa(_addExercicio);
        });
  }

  _remove(Exercicio exercicio) {
    MensagemUtil.confirmar(context, 'Remover Registro',
        "Remover o Exercício \"${exercicio.nome}\"?", () {
      exercicioService.delete(exercicio.id);
      _getLista();
      Navigator.pop(context);
    });
  }

  _addExercicio(Exercicio exercicio) async {
    exercicio.rotinaId = widget.rotina.id;

    Navigator.pop(context);

    await exercicioService.salvar(exercicio);

    await _getLista();
  }

  _reorderRounds(int oldOrder, int newOrder) async {
    if (oldOrder < newOrder) {
      newOrder -= 1;
    }
    final Exercicio item = lista.removeAt(oldOrder);
    setState(() {
      lista.insert(newOrder, item);
    });

    for (var i = 0; i < lista.length; i++) {
      exercicioService.setOrdem(lista[i].id, i + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    var status = StatusRotina(rotina: rotina, lista: lista, tempo: tempo);

    Flexible consulta = Flexible(
      child:
          ExercicioList(lista, _remove, _cadastrar, _seleciona, _reorderRounds),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          rotina?.nome ?? "",
        ),
        actions: [
          IconButton(
            onPressed: _cadastrarPausa,
            icon: const Icon(Icons.add_box),
            tooltip: "Adicionar Pausa",
          ),
          IconButton(onPressed: _editar, icon: const Icon(Icons.edit)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                status,
                Text(
                  "Exercícios",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ),
          consulta
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _cadastrar(null),
        tooltip: 'Novo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
