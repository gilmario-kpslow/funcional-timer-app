import 'package:flutter/material.dart';
import 'package:cristimer/core/util/mensagem.dart';
import 'package:cristimer/core/database/databaseutil.dart';

class Configuracao extends StatelessWidget {
  const Configuracao({super.key});

  _criarBanco(BuildContext context) async {
    try {
      await DatabaseUtil.recriarBanco();
      if (context.mounted) {
        Notificacao.info(context, "Banco recriando com sucesso!");
      }
    } catch (e) {
      if (context.mounted) {
        Notificacao.error(context, "Erro: $e");
      }
    }
  }

  _removeBanco(BuildContext context) async {
    try {
      await DatabaseUtil.removerBanco();
      Notificacao.info(context, "Banco removido com sucesso!");
    } catch (e) {
      Notificacao.error(context, "Erro: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        // actions: [
        //   // IconButton(onPressed: () {}, icon: const Icon(Icons.gesture))
        // ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: ElevatedButton(
              onPressed: () {
                _removeBanco(context);
              },
              child: const Text("Remover banco"),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: ElevatedButton(
              onPressed: () {
                _criarBanco(context);
              },
              child: const Text("Recriar banco"),
            ),
          ),
        ],
      ),
    );
  }
}
