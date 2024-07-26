import 'package:flutter/material.dart';
import './modelos/programacao.dart';

class Painel extends StatelessWidget {
  const Painel({super.key});

  @override
  Widget build(BuildContext context) {
    List<Programacao> lista = [
      Programacao(nome: 'Programa 01', segundos: 300, tocarSom: true),
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
