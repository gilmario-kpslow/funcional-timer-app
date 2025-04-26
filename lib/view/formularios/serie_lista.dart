import 'package:cristimer/core/modelos/serie.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/components/popup_menu.dart';
import 'package:cristimer/core/util/menu_template.dart';
import 'package:cristimer/enums/menu_item_option.dart';

class SerieList extends StatelessWidget {
  const SerieList(
      this.lista, this.delete, this.editar, this.selecionar, this._reorder,
      {super.key});

  final List<Serie> lista;
  final Function(Serie entity) delete;
  final Function(Serie entity) editar;
  final Function(Serie entity) selecionar;
  final Function(int index, int newIndex) _reorder;
  static const List<MenuTemplate> _opcoes = [
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
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Nenhuma serie registrada",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ]),
      );
    });

    final listaComponent = ReorderableListView.builder(
        onReorder: _reorder,
        itemCount: lista.length,
        itemBuilder: (context, index) {
          final tr = lista[index];

          return Padding(
            padding: const EdgeInsets.all(2),
            key: Key("${tr.id}"),
            child: ListTile(
              onLongPress: () => delete(tr),
              tileColor: Theme.of(context).colorScheme.onTertiary,
              title: Text(
                tr.nome,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              // subtitle: Text(
              //   "${TempoUtil.format(tr.tempo)} ${tr.descricao}",
              //   style: Theme.of(context).textTheme.labelMedium,
              // ),
              trailing: PopupMenu(
                select: _menuSelect,
                value: tr,
                template: _opcoes,
              ),
              leading: Text(
                "${index + 1}",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          );
        });

    return SizedBox(child: lista.isEmpty ? vazio : listaComponent);
  }
}
