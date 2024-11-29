import 'package:cristimer/core/util/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/core/modelos/rotina.dart';

class RotinaList extends StatelessWidget {
  const RotinaList(this.programacoes, this.delete, this.editar, this.selecionar,
      {super.key});

  final List<Rotina> programacoes;
  final Function(Rotina entity) delete;
  final Function(Rotina entity) editar;
  final Function(Rotina entity) selecionar;

  @override
  Widget build(BuildContext context) {
    final vazio = LayoutBuilder(builder: (xtx, constraints) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Nenhuma registro",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ]),
      );
    });

    final lista = ListView.builder(
        itemCount: programacoes.length,
        itemBuilder: (context, index) {
          final tr = programacoes[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.onTertiary,
              onTap: () => selecionar(tr),
              onLongPress: () {
                delete(tr);
              },
              title: Text(
                tr.nome,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                tr.descricao ?? "",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              leading: Text(
                "${tr.id}",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          );
        });

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(child: programacoes.isEmpty ? vazio : lista),
    );
  }
}
