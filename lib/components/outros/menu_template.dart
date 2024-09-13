import 'package:flutter/material.dart';
import 'package:cristimer/enums/menu_item_option.dart';

class MenuTemplate {
  final String titulo;
  final IconData icone;
  final MenuItemOption valor;

  const MenuTemplate(
      {required this.titulo, required this.icone, required this.valor});
}
