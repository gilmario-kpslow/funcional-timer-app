import 'package:flutter/material.dart';
import 'package:cristimer/components/layout/popup_menu.dart';
import 'package:cristimer/components/outros/menu_template.dart';
import 'package:cristimer/core/modelos/round.dart';
import 'package:cristimer/core/util/tempoutil.dart';
import 'package:cristimer/enums/menu_item_option.dart';

class RoundList extends StatelessWidget {
  const RoundList(
      this.lista, this.delete, this.editar, this.selecionar, this._reorder,
      {super.key});

  final List<Round> lista;
  final Function(Round entity) delete;
  final Function(Round entity) editar;
  final Function(Round entity) selecionar;
  final Function(int index, int newIndex) _reorder;
  static const List<MenuTemplate> _opcoes = [
    MenuTemplate(
        titulo: "Selecionar",
        icone: Icons.check,
        valor: MenuItemOption.selecionar),
    MenuTemplate(
        titulo: "Editar", icone: Icons.edit, valor: MenuItemOption.editar),
    MenuTemplate(
        titulo: "Remover", icone: Icons.remove, valor: MenuItemOption.excluir)
  ];

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
      case MenuItemOption.visualizar:
        break;
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
            trailing: PopupMenu(
              select: _menuSelect,
              value: tr,
              template: _opcoes,
            ),
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
