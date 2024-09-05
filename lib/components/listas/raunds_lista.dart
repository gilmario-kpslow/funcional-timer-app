import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/layout/popup_menu.dart';
import 'package:funcional_timer_app/core/modelos/round.dart';
import 'package:funcional_timer_app/core/util/tempoutil.dart';
import 'package:funcional_timer_app/enums/menu_item_option.dart';

class RoundList extends StatelessWidget {
  const RoundList(
      this.lista, this.delete, this.editar, this.selecionar, this._reorder,
      {super.key});

  final List<Round> lista;
  final Function(Round entity) delete;
  final Function(Round entity) editar;
  final Function(Round entity) selecionar;
  final Function(int index, int newIndex) _reorder;

  _menuSelect(MenuItemOption option, dynamic value) {
    switch (option) {
      case MenuItemOption.editar:
        {
          editar(value);
          break;
        }
      case MenuItemOption.excluir:
        {
          delete(value);
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

    final listaComponent = ReorderableListView.builder(
        onReorder: _reorder,
        itemCount: lista.length,
        itemBuilder: (context, index) {
          final tr = lista[index];
          return ListTile(
            key: Key("${tr.id}"),
            title: Text(
              tr.nome,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(
              "${TempoUtil.format(tr.tempo)} ${tr.descricao ?? ""}",
            ),
            trailing: PopupMenu(select: _menuSelect, value: tr),
            leading: Text("${tr.id} ${tr.ordem}"),
            // trailing: IconButton(
            //   icon: const Icon(Icons.list),
            //   onPressed: () {

            //   },
            //   color: Theme.of(context).colorScheme.error,
            // ),
          );
        });

    return SizedBox(child: lista.isEmpty ? vazio : listaComponent);
  }
}
