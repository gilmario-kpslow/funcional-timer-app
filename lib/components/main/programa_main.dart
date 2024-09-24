import 'package:cristimer/components/layout/mensagem_util.dart';
import 'package:cristimer/components/main/configuracao_programa.dart';
// import 'package:cristimer/components/outros/configuracao.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/components/formularios/round_form.dart';
import 'package:cristimer/components/layout/status_programa.dart';
import 'package:cristimer/components/listas/raunds_lista.dart';
import 'package:cristimer/components/outros/programa_form_service.dart';
import 'package:cristimer/core/modelos/programacao.dart';
import 'package:cristimer/core/modelos/round.dart';
import 'package:cristimer/core/service/programacao_service.dart';
import 'package:cristimer/core/service/round_service.dart';
import 'package:cristimer/core/util/tempoutil.dart';

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
  String tempo = "";
  int selectedIndex = 0;
  ProgramaFormService formService = ProgramaFormService();
  Programacao? programacao;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    _getLista();
    setState(() {
      programacao = widget.programacao;
    });
  }

  _editarProgramacao() async {
    formService.showFormDialog(context, _addProgramacao, programacao);
  }

  _addProgramacao() async {
    Navigator.pop(context);
    var p = await service.get(programacao?.id);

    setState(() {
      programacao = p;
    });
  }

  _getLista() async {
    var list = await roudeService.getLista(widget.programacao.id);

    var t = list.isEmpty ? 0 : list.map((r) => r.tempo).reduce((a, b) => a + b);

    setState(() {
      lista = list;
      tempo = TempoUtil.format(t);
    });
  }

  _configurar() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ConfiguracaoPrograma();
    })).then((a) {
      _init();
    });
  }

  _selecionaRound(Round round) {}

  _cadastrarRound(Round? round) async {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return RoundForm(_addRound, round);
        });
  }

  _cadastrarPausa() async {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return RoundForm.pausa(_addRound);
        });
  }

  _removeRound(Round round) {
    MensagemUtil.confirmar(
        context, 'Remover Registro', "Remover o Round ${round.nome}.", () {
      roudeService.delete(round.id);
      _getLista();
      Navigator.pop(context);
    });

    // showDialog(
    //     useSafeArea: true,
    //     context: context,
    //     builder: (ctx) {
    //       return AlertDialog(
    //         title: const Text('Remover Registro'),
    //         content: SingleChildScrollView(
    //           child: ListBody(
    //             children: <Widget>[
    //               Text("Remover o Round ${round.nome}."),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text('Cancelar'),
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //           TextButton(
    //             child: const Text('Confirmar'),
    //             onPressed: () {},
    //           ),
    //         ],
    //       );
    //     });
  }

  _addRound(Round round) async {
    Programacao programacao = widget.programacao;
    round.programacaoId = programacao.id;

    Navigator.pop(context);

    await roudeService.salvar(round);

    await _getLista();
  }

  _reorderRounds(int oldOrder, int newOrder) async {
    if (oldOrder < newOrder) {
      newOrder -= 1;
    }
    final Round item = lista.removeAt(oldOrder);
    setState(() {
      lista.insert(newOrder, item);
    });

    for (var i = 0; i < lista.length; i++) {
      roudeService.setOrdem(lista[i].id, i + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    var status =
        StatusPrograma(programacao: programacao, lista: lista, tempo: tempo);

    RoundList consulta = RoundList(
        lista, _removeRound, _cadastrarRound, _selecionaRound, _reorderRounds);

    var widgets = [status, consulta];

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.info),
            label: 'Status',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Rounds',
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(programacao?.nome ?? ""),
        primary: true,
        actions: [
          // IconButton(
          //   onPressed: _configurar,
          //   icon: const Icon(Icons.settings),
          //   tooltip: "COnfigurações",
          // ),
          IconButton(
            onPressed: _cadastrarPausa,
            icon: const Icon(Icons.add_box),
            tooltip: "Adicionar Pausa",
          ),
          IconButton(
              onPressed: _editarProgramacao, icon: const Icon(Icons.edit)),
        ],
      ),
      body: widgets[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _cadastrarRound(null),
        tooltip: 'Novo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
