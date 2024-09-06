import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/layout/popup_menu.dart';
import 'package:funcional_timer_app/components/outros/menu_template.dart';
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
  static const List<MenuTemplate> _opcoes = [
    MenuTemplate(
        icone: Icons.check,
        titulo: "Selecionar",
        valor: MenuItemOption.selecionar),
    MenuTemplate(
        titulo: "Visualizar",
        icone: Icons.remove_red_eye,
        valor: MenuItemOption.visualizar),
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
          delete(value.id);
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
            title: Text(
              tr.nome,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(
              tr.descricao,
            ),
            trailing:
                PopupMenu(select: _menuSelect, value: tr, template: _opcoes),
            leading: Text("${tr.id}"),
          );
        });

    return SizedBox(child: programacoes.isEmpty ? vazio : lista);
  }
}
