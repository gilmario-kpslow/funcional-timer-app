import 'package:flutter/material.dart';
import 'package:funcional_timer_app/enums/menu_item_option.dart';

class PopupMenu extends StatelessWidget {
  final void Function(MenuItemOption option, dynamic value) select;
  final dynamic value;

  const PopupMenu({super.key, required this.select, required this.value});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (option) => select(option, value),
        itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: MenuItemOption.selecionar,
                child: ListTile(
                  title: Text("Selecionar"),
                  leading: Icon(Icons.check),
                ),
              ),
              const PopupMenuItem(
                value: MenuItemOption.editar,
                child: ListTile(
                  title: Text("Editar"),
                  leading: Icon(Icons.edit),
                ),
              ),
              const PopupMenuItem(
                value: MenuItemOption.excluir,
                child: ListTile(
                  title: Text("Excluir"),
                  leading: Icon(Icons.remove),
                ),
              )
            ]);
  }
}
