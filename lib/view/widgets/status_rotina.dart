import 'package:flutter/material.dart';
import 'package:cristimer/core/modelos/rotina.dart';
import 'package:cristimer/core/modelos/exercicio.dart';

class StatusRotina extends StatelessWidget {
  const StatusRotina({
    super.key,
    required this.rotina,
    required this.lista,
    required this.tempo,
  });

  final Rotina? rotina;
  final List<Exercicio> lista;
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
                // _info("Nome", programacao?.nome ?? ""),
                // _info("Descrição", programacao?.descricao ?? ""),

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

class DadoRotina extends StatelessWidget {
  final String texto;
  const DadoRotina({
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
