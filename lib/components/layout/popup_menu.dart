import 'package:flutter/material.dart';
import 'package:cristimer/components/outros/menu_template.dart';
import 'package:cristimer/enums/menu_item_option.dart';

class PopupMenu extends StatelessWidget {
  final void Function(MenuItemOption option, dynamic value) select;
  final dynamic value;
  final List<MenuTemplate> template;

  const PopupMenu(
      {super.key,
      required this.select,
      required this.value,
      required this.template});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (option) => select(option, value),
      itemBuilder: (BuildContext context) => template
          .map(
            (item) => PopupMenuItem(
              value: item.valor,
              child: ListTile(
                title: Text(item.titulo),
                leading: Icon(item.icone),
              ),
            ),
          )
          .toList() as List<PopupMenuItem>,
    );
  }
}
