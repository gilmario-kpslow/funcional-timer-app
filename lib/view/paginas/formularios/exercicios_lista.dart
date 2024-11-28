import 'package:cristimer/core/util/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/widgets/popup_menu.dart';
import 'package:cristimer/core/util/menu_template.dart';
import 'package:cristimer/core/modelos/exercicio.dart';
import 'package:cristimer/core/util/tempoutil.dart';
import 'package:cristimer/enums/menu_item_option.dart';

class ExercicioList extends StatelessWidget {
  const ExercicioList(
      this.lista, this.delete, this.editar, this.selecionar, this._reorder,
      {super.key});

  final List<Exercicio> lista;
  final Function(Exercicio entity) delete;
  final Function(Exercicio entity) editar;
  final Function(Exercicio entity) selecionar;
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
            "Nenhuma round registrado",
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
              tileColor: Theme.of(context).colorScheme.onTertiary,
              title: Text(
                tr.nome,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                "${TempoUtil.format(tr.tempo)} ${tr.descricao}",
              ),
              trailing: PopupMenu(
                select: _menuSelect,
                value: tr,
                template: _opcoes,
              ),
              leading: Text(
                "${index + 1}",
                style: const TextStyle(fontSize: 20),
              ),
              // leading: tr.nome == 'Pausa'
              //     ? const Icon(Icons.pause)
              //     : const Icon(Icons.play_arrow_outlined),
            ),
          );
        });

    return SizedBox(child: lista.isEmpty ? vazio : listaComponent);
  }
}
