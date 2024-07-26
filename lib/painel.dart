import 'package:flutter/material.dart';
import './modelos/programacao.dart';

class Painel extends StatelessWidget {
  const Painel({super.key});

  @override
  Widget build(BuildContext context) {
    List<Programacao> lista = [
      Programacao(nome: "Funcional 01", id: 1),
      Programacao(nome: "Funcional 02", id: 2),
      Programacao(nome: "Funcional 03", id: 3)
    ];

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
          useMaterial3: true,
        ),
        home: const Text("TESTE"));
  }
}
