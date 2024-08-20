import 'package:flutter/material.dart';

class Configuracao extends StatelessWidget {
  final _tabelaController = TextEditingController();

  _criarBanco() {
    print(_tabelaController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.gesture))],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _criarBanco,
            child: Text("Criar tabela selecionada"),
          ),
          DropdownMenu(controller: _tabelaController, dropdownMenuEntries: [
            DropdownMenuEntry(value: "Programacao", label: "Programação"),
            DropdownMenuEntry(value: "Round", label: "Rounds"),
          ]),
        ],
      ),
    );
  }
}
