import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/formularios/programacao_form.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';
import 'package:funcional_timer_app/core/service/programacao_service.dart';

class ProgramaFormService {
  ProgramacaoService service = ProgramacaoService();

  showFormDialog(context, Function callBack, Programacao? programacao) {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (ctx) {
          return ProgramacaoForm((Programacao programacao) async {
            await _addProgramacao(programacao);
            callBack();
          }, programacao);
        });
  }

  _addProgramacao(Programacao p) async {
    await service.salvar(p);
  }
}
