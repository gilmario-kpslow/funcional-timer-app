import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/formularios/round_form.dart';
import 'package:funcional_timer_app/components/listas/raunds_lista.dart';
import 'package:funcional_timer_app/components/outros/programa_form_service.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';
import 'package:funcional_timer_app/core/modelos/round.dart';
import 'package:funcional_timer_app/core/service/programacao_service.dart';
import 'package:funcional_timer_app/core/service/round_service.dart';
import 'package:funcional_timer_app/core/util/tempoutil.dart';

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
    _getLista();
    setState(() {
      programacao = widget.programacao;
    });
  }

  _editarProgramacao() async {
    formService.showFormDialog(context, _addProgramacao, programacao);
  }

  _addProgramacao() async {
    var p = await service.get(programacao?.id);

    setState(() {
      programacao = p;
    });

    Navigator.pop(context);
  }

  _getLista() async {
    var list = await roudeService.getLista(widget.programacao.id);

    var t = list.isEmpty ? 0 : list.map((r) => r.tempo).reduce((a, b) => a + b);

    setState(() {
      lista = list;
      tempo = TempoUtil.format(t);
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

  _removeRound(Round round) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Remover Registro'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Remover o Round ${round.nome}."),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Confirmar'),
                onPressed: () {
                  roudeService.delete(round.id);
                  _getLista();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  _addRound(Round round) async {
    Programacao programacao = widget.programacao;
    round.programacaoId = programacao.id;

    await roudeService.salvar(round);

    await _getLista();
    Navigator.pop(context);
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
    // Programacao programacao = widget.programacao;

    var status = SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DadoPrograma(
                    texto: "Status: ${programacao?.status}",
                  ),
                  DadoPrograma(
                    texto: "Descrição: ${programacao?.descricao}",
                  ),
                  DadoPrograma(
                    texto: "Número de Rounds: ${lista.length}",
                  ),
                  Text(
                    "Duração: $tempo",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

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
            // selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.info),
            label: 'Status',
          ),
          NavigationDestination(
            // selectedIcon: Icon(Icons.list_alt),
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

class DadoPrograma extends StatelessWidget {
  final String texto;
  const DadoPrograma({
    super.key,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        texto,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
