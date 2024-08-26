import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/layout/popup_menu.dart';
import 'package:funcional_timer_app/core/modelos/round.dart';
import 'package:funcional_timer_app/enums/menu_item_option.dart';

class RoundList extends StatelessWidget {
  const RoundList(this.lista, this.delete, this.editar, this.selecionar,
      {super.key});

  final List<Round> lista;
  final Function(int id) delete;
  final Function(Round entity) editar;
  final Function(Round entity) selecionar;

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
                "Nenhuma round registrado",
                style: Theme.of(context).textTheme.titleLarge,
                // textAlign: TextAlign.center,
              ),
            ]),
      );
    });

    final listaComponent = ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index) {
          final tr = lista[index];
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
                tr.nome,
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

    return SizedBox(child: lista.isEmpty ? vazio : listaComponent);
  }
}
