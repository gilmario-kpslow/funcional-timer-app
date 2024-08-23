import 'package:flutter/material.dart';

class Notificacao {
  static info(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensagem),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
    ));
  }

  static error(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensagem),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: Colors.red,
    ));
  }
}
