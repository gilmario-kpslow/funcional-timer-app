import 'package:flutter/material.dart';
import 'package:cristimer/core/modelos/programacao.dart';
import 'package:cristimer/core/modelos/round.dart';

class StatusPrograma extends StatelessWidget {
  const StatusPrograma({
    super.key,
    required this.programacao,
    required this.lista,
    required this.tempo,
  });

  final Programacao? programacao;
  final List<Round> lista;
  final String tempo;

  _info(String titulo, String valor) {
    return Container(
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
      child: ListTile(
        dense: false,
        leading: const Icon(Icons.arrow_right),
        title: Text(titulo),
        trailing: Text(
          valor,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _info("Nome", programacao?.nome ?? ""),
                _info("Descrição", programacao?.descricao ?? ""),
                _info("Execícios", "${lista.length}"),
                _info("Duração", tempo),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DadoPrograma extends StatelessWidget {
  final String texto;
  const DadoPrograma({
    super.key,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        texto,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
