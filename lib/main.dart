// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/drawer.dart';
import 'package:funcional_timer_app/components/executar_round.dart';
import 'package:funcional_timer_app/components/programacao_form.dart';
import 'package:funcional_timer_app/components/programacao_list.dart';
import 'package:funcional_timer_app/components/round_form.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';
import 'package:funcional_timer_app/core/service/programacao_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Funcional APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Programacao> lista = List.empty();
  ProgramacaoService service = ProgramacaoService();

  void _cadastrarProgramacao() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return ProgramacaoForm(_addProgramacao);
        });
  }

  _addProgramacao(String descricao, String nome) async {
    final p = Programacao(0, nome, descricao);
    await service.salvar(p);
    var list = await service.getLista();

    setState(() {
      lista = list;
    });

    Navigator.of(context).pop();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _addData(String nome, int tempo) {}

  @override
  Widget build(BuildContext context) {
    ProgramacaoList programacoes = ProgramacaoList(
        lista, (id) {}, (Programacao entity) {}, (Programacao entity) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ExecutarRound(entity)),
      );
    });
    var round = RoundForm(_addData);

    List<Widget> _widgetOptions = <Widget>[programacoes, round];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Funcional APP"),
      ),
      body: _widgetOptions[_selectedIndex],
      drawer: DefaultDrawer(_onItemTapped, index: _selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: _cadastrarProgramacao,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
