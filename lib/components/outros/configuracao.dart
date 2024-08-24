import 'package:flutter/material.dart';
import 'package:funcional_timer_app/core/util/mensagem.dart';
import 'package:funcional_timer_app/core/database/databaseutil.dart';

class Configuracao extends StatelessWidget {
  // final _tabelaController = TextEditingController();

  _criarBanco(BuildContext context) async {
    try {
      await DatabaseUtil.recriarBanco();
      Notificacao.info(context, "Banco recriando com sucesso!");
    } catch (e) {
      Notificacao.error(context, "Erro: $e");
    }
  }

  _removeBanco(BuildContext context) async {
    try {
      await DatabaseUtil.removerBanco();
      Notificacao.info(context, "Banco removido com sucesso!");
    } catch (e) {
      Notificacao.error(context, "Erro: ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.gesture))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ButtonStyle(),
            onPressed: () {
              _removeBanco(context);
            },
            child: Text("Remover banco"),
          ),
          ElevatedButton(
            onPressed: () {
              _criarBanco(context);
            },
            child: Text("Recriar banco"),
          ),
          // DropdownMenu(controller: _tabelaController, dropdownMenuEntries: [
          //   DropdownMenuEntry(value: "Programacao", label: "Programação"),
          //   DropdownMenuEntry(value: "Round", label: "Rounds"),
          // ]),
        ],
      ),
    );
  }
}
