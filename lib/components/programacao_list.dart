import 'package:flutter/material.dart';
import 'package:funcional_timer_app/modelos/programacao.dart';

class ProgramacaoList extends StatelessWidget {
  const ProgramacaoList(this.programacoes, this.delete, {super.key});

  final List<Programacao> programacoes;
  final Function(int id) delete;

  @override
  Widget build(BuildContext context) {
    final vazio = LayoutBuilder(builder: (xtx, constraints) {
      return Column(children: [
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        SizedBox(
          height: constraints.maxHeight * 0.20,
          child: Text(
            "Nenhuma registro",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        SizedBox(
          height: constraints.maxHeight * 0.50,
          child: Image.asset(
            "assets/images/waiting.png",
            fit: BoxFit.fitHeight,
          ),
        ),
      ]);
    });

    final lista = ListView.builder(
        itemCount: programacoes.length,
        itemBuilder: (context, index) {
          final tr = programacoes[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              title: Text(
                tr.nome,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                tr.descricao,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  delete(tr.id);
                },
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          );
        });

    return SizedBox(child: programacoes.isEmpty ? vazio : lista);
  }
}
