import 'package:flutter/material.dart';

class Configuracao extends StatelessWidget {
  const Configuracao({super.key});

  // _criarBanco(BuildContext context) async {
  //   try {
  //     await DatabaseUtil.recriarBanco();
  //     if (context.mounted) {
  //       Notificacao.info(context, "Banco recriando com sucesso!");
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       Notificacao.error(context, "Erro: $e");
  //     }
  //   }
  // }

  // _removeBanco(BuildContext context) async {
  //   try {
  //     await DatabaseUtil.removerBanco();
  //     Notificacao.info(context, "Banco removido com sucesso!");
  //   } catch (e) {
  //     Notificacao.error(context, "Erro: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Configurações",
          // style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Theme.of(context).colorScheme.primary,
        // iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Realizar backup e restore da base de dados.",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.label_important_sharp,
              color: Colors.redAccent,
              size: 30,
            ),
            onTap: () {},
            title: const Text(
              "Fazer backup",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.label_important_sharp,
              color: Colors.redAccent,
              size: 30,
            ),
            onTap: () {},
            title: const Text(
              "Restaurar backup",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
