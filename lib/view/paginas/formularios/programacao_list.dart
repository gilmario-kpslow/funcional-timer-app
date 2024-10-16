import 'package:flutter/material.dart';
import 'package:cristimer/view/widgets/popup_menu.dart';
import 'package:cristimer/core/util/menu_template.dart';
import 'package:cristimer/enums/menu_item_option.dart';
import 'package:cristimer/core/modelos/programacao.dart';

class ProgramacaoList extends StatelessWidget {
  const ProgramacaoList(
      this.programacoes, this.delete, this.editar, this.selecionar,
      {super.key});

  final List<Programacao> programacoes;
  final Function(Programacao entity) delete;
  final Function(Programacao entity) editar;
  final Function(Programacao entity) selecionar;
  static const List<MenuTemplate> _opcoes = [
    MenuTemplate(
        icone: Icons.check,
        titulo: "Selecionar",
        valor: MenuItemOption.selecionar),
    MenuTemplate(
        titulo: "Editar", icone: Icons.edit, valor: MenuItemOption.visualizar),
    MenuTemplate(
        titulo: "Excluir", icone: Icons.remove, valor: MenuItemOption.excluir),
  ];

  _menuSelect(MenuItemOption option, dynamic value) {
    switch (option) {
      case MenuItemOption.visualizar:
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

      case MenuItemOption.editar:
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
          return ListTile(
            tileColor: const Color.fromARGB(255, 255, 174, 174),
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
            ),
            // trailing:
            //     PopupMenu(select: _menuSelect, value: tr, template: _opcoes),
            leading: Text("${tr.id}"),
            hoverColor: Color(Colors.amberAccent.value),
            dense: false,
          );
        });

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(child: programacoes.isEmpty ? vazio : lista),
    );
  }
}
