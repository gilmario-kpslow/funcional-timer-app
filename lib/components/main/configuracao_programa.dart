import 'package:flutter/material.dart';

class ConfiguracaoPrograma extends StatefulWidget {
  const ConfiguracaoPrograma({super.key});

  @override
  State<ConfiguracaoPrograma> createState() => _ConfiguracaoProgramaState();
}

class _ConfiguracaoProgramaState extends State<ConfiguracaoPrograma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuração"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Text("data"),
        ],
      ),
    );
  }
}
