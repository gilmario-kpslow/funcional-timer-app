import 'package:funcional_timer_app/core/modelos/programacao.dart';
import 'package:funcional_timer_app/core/service/preferencia_service.dart';

class ProgramacaoService {
  PreferenciaService preferencia = PreferenciaService();

  salvar(Programacao programacao) {
    preferencia.setValue(programacao.toJson(), Preferencia.programacao);
  }
}
