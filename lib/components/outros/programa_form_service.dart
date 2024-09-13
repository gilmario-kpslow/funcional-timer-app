import 'package:flutter/material.dart';
import 'package:cristimer/components/formularios/programacao_form.dart';
import 'package:cristimer/core/modelos/programacao.dart';
import 'package:cristimer/core/service/programacao_service.dart';

class ProgramaFormService {
  ProgramacaoService service = ProgramacaoService();

  showFormDialog(context, Function callBack, Programacao? programacao) {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (ctx) {
          return ProgramacaoForm((Programacao programacao) async {
            await _addProgramacao(programacao);
            await callBack();
          }, programacao);
        });
  }

  _addProgramacao(Programacao p) async {
    await service.salvar(p);
  }
}
