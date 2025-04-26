import 'package:flutter/material.dart';
import 'package:cristimer/view/formularios/rotina_form.dart';
import 'package:cristimer/core/modelos/rotina.dart';
import 'package:cristimer/core/service/rotina_service.dart';

class RotinaFormService {
  RotinaService service = RotinaService();

  showFormDialog(context, Function callBack, Rotina? rotina) {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (ctx) {
          return RotinaForm((Rotina rotina) async {
            await _add(rotina);
            await callBack();
          }, rotina);
        });
  }

  _add(Rotina p) async {
    await service.salvar(p);
  }
}
