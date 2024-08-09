import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/drawer.dart';
import 'package:funcional_timer_app/components/executar_round.dart';
import 'package:funcional_timer_app/components/programacao_list.dart';
import 'package:funcional_timer_app/components/round_form.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';

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

  void _incrementCounter() {
    print('_incrementCounter');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _addData(String nome, int tempo) {}

  @override
  Widget build(BuildContext context) {
    ProgramacaoList programacoes = ProgramacaoList(lista, (id) {
      print(id);
      print("Excluir");
    }, (Programacao entity) {
      print("Editar");
      print(entity);
    });
    const main = ExecutarRound();
    var round = RoundForm(_addData);
    const painel = Text("Programacoes");

    List<Widget> _widgetOptions = <Widget>[programacoes, round, main];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Funcional APP"),
      ),
      body: _widgetOptions[_selectedIndex],
      drawer: DefaultDrawer(_onItemTapped, index: _selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
