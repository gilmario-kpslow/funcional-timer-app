import 'package:cristimer/core/modelos/serie.dart';
import 'package:cristimer/core/service/serie_service.dart';
import 'package:cristimer/core/util/mensagem_util.dart';
import 'package:cristimer/view/formularios/serie_form.dart';
import 'package:cristimer/view/formularios/serie_lista.dart';
import 'package:cristimer/view/paginas/nova_serie.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/formularios/exercicio_form.dart';
import 'package:cristimer/view/components/status_rotina.dart';
import 'package:cristimer/view/formularios/exercicios_lista.dart';
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
  SerieService serieService = SerieService();
  List<Serie> lista = List.empty();
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
    var list = await serieService.getListaPorRotina(rotina?.id);

    // var t = list.isEmpty ? 0 : list.map((r) => r.tempo).reduce((a, b) => a + b);
    var t = 0;

    setState(() {
      lista = list;
      tempo = TempoUtil.format(t);
    });
  }

  _seleciona(Serie serie) {}

  _cadastrar(Serie? serie) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NovaSerie(
          rotinaID: rotina?.id,
          serie: serie,
        ),
      ),
    ).then((resp) {
      _init();
    });
  }

  _cadastrarPausa() async {
    // showDialog(
    //     useSafeArea: true,
    //     context: context,
    //     builder: (ctx) {
    //       // return SerieForm.pausa(_addExercicio);
    //       // return Text("OK");
    //     });
  }

  _remove(Serie serie) {
    MensagemUtil.confirmar(
        context, 'Remover registro', "Remover a Serie \"${serie.nome}\"?", () {
      serieService.delete(serie.id);
      _getLista();
      Navigator.pop(context);
    });
  }

  _addExercicio(Serie serie) async {
    serie.rotinaId = widget.rotina.id;

    Navigator.pop(context);

    await serieService.salvar(serie);

    await _getLista();
  }

  _reorderRounds(int oldOrder, int newOrder) async {
    if (oldOrder < newOrder) {
      newOrder -= 1;
    }
    final Serie item = lista.removeAt(oldOrder);
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
          // ExercicioList(lista, _remove, _cadastrar, _seleciona, _reorderRounds),
          SerieList(lista, _remove, _cadastrar, _seleciona, _reorderRounds),
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
                  "Series",
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
