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
                // ListTile(
                //   leading: const Text("Descrição"),
                //   // title: const Text("Descrição"),
                //   title: Text("${programacao?.descricao}"),
                // ),
                // ListTile(
                //   title: const Text("Status"),
                //   trailing: Text("${programacao?.status}"),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Status"), Text("Outro")],
                ),
                DadoPrograma(
                  texto: "Status: ${programacao?.status}",
                ),
                DadoPrograma(
                  texto: "Descrição: ${programacao?.descricao}",
                ),
                DadoPrograma(
                  texto: "Número de Rounds: ${lista.length}",
                ),
                Text(
                  "Duração: $tempo",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
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
