import 'package:flutter/material.dart';

class ConfiguracaoRotina extends StatefulWidget {
  const ConfiguracaoRotina({super.key});

  @override
  State<ConfiguracaoRotina> createState() => _ConfiguracaoProgramaState();
}

class _ConfiguracaoProgramaState extends State<ConfiguracaoRotina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarDef(titulo: "Configuração") as AppBar,
      appBar: AppBar(
        title: Text(
          "sdfsd",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Column(
        children: [
          Text("data"),
        ],
      ),
    );
  }
}
