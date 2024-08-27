import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/formularios/round_form.dart';
import 'package:funcional_timer_app/components/layout/drawer.dart';
import 'package:funcional_timer_app/components/listas/dashboard.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';
import 'package:funcional_timer_app/core/modelos/round.dart';
import 'package:funcional_timer_app/core/service/programacao_service.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _selectedIndex = 0;

  List<Programacao> lista = List.empty();
  ProgramacaoService service = ProgramacaoService();

  _addData(Round entity) {}

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var round = RoundForm(_addData);

    var dashboard = const Dashboard();

    List<Widget> widgetOptions = <Widget>[dashboard, round];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Funcional Timer APP"),
      ),
      body: widgetOptions[_selectedIndex],
      drawer: DefaultDrawer(_onItemTapped, index: _selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
