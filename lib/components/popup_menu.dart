import 'package:flutter/material.dart';
import 'package:funcional_timer_app/enums/menu_item_option.dart';

class PopupMenu extends StatelessWidget {
  final void Function(MenuItemOption option, dynamic value) select;
  final dynamic value;

  PopupMenu({super.key, required this.select, required this.value});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (option) => select(option, value),
        itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: MenuItemOption.Editar,
                child: ListTile(
                  title: Text("Editar"),
                  leading: Icon(Icons.edit),
                ),
              ),
              PopupMenuItem(
                value: MenuItemOption.Excluir,
                child: ListTile(
                  title: Text("Excluir"),
                  leading: Icon(Icons.remove),
                ),
              )
            ]);
  }
}
