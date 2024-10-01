import 'package:cristimer/core/util/tipo.dart';
import 'package:flutter/material.dart';

class MensagemUtil {
  static mensagem(context, String titulo, String mensagem, TipoMensagem tipo) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(titulo),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(mensagem),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static info(context, String titulo, String mensagem) {
    MensagemUtil.mensagem(context, titulo, mensagem, TipoMensagem.info);
  }

  static atencao(context, String titulo, String mensagem) {
    MensagemUtil.mensagem(context, titulo, mensagem, TipoMensagem.atencao);
  }

  static erro(context, String titulo, String mensagem) {
    MensagemUtil.mensagem(context, titulo, mensagem, TipoMensagem.erro);
  }

  static sucesso(context, String titulo, String mensagem) {
    MensagemUtil.mensagem(context, titulo, mensagem, TipoMensagem.sucesso);
  }

  static confirmar(context, String titulo, String info, Function call) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(titulo),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(info),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text(
                  'Confirmar',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  call();
                },
              ),
            ],
          );
        });
  }
}
