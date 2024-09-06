import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/formularios/programacao_form.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';
import 'package:funcional_timer_app/core/service/programacao_service.dart';

class ProgramaFormService {
  ProgramacaoService service = ProgramacaoService();

// Function(Programacao programa) callback;
  showFormDialog(context, Function(Programacao programa) callBack) {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (ctx) {
          return ProgramacaoForm((String nome, String descricao) async {
            var p = await _addProgramacao(nome, descricao);
            callBack(p);
          });
        });
  }

  Future<Programacao> _addProgramacao(String nome, String descricao) async {
    final p = Programacao.basico(nome, descricao, STATUS_ATIVO);
    await service.salvar(p);
    return p;
  }
}
