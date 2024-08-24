import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/layout/popup_menu.dart';
import 'package:funcional_timer_app/enums/menu_item_option.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';

class ProgramacaoList extends StatelessWidget {
  const ProgramacaoList(
      this.programacoes, this.delete, this.editar, this.selecionar,
      {super.key});

  final List<Programacao> programacoes;
  final Function(int id) delete;
  final Function(Programacao entity) editar;
  final Function(Programacao entity) selecionar;

  _menuSelect(MenuItemOption option, dynamic value) {
    switch (option) {
      case MenuItemOption.editar:
        {
          editar(value);
          break;
        }
      case MenuItemOption.excluir:
        {
          delete(value.id);
          break;
        }
      case MenuItemOption.selecionar:
        {
          selecionar(value);
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vazio = LayoutBuilder(builder: (xtx, constraints) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Nenhuma registro",
                style: Theme.of(context).textTheme.titleLarge,
                // textAlign: TextAlign.center,
              ),
            ]),
      );
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
              trailing: PopupMenu(select: _menuSelect, value: tr),
              leading: Text("${tr.id}"),
              // trailing: IconButton(
              //   icon: const Icon(Icons.list),
              //   onPressed: () {

              //   },
              //   color: Theme.of(context).colorScheme.error,
              // ),
            ),
          );
        });

    return SizedBox(child: programacoes.isEmpty ? vazio : lista);
  }
}
