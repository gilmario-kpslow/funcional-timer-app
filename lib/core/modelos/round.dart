import 'package:funcional_timer_app/core/modelos/entity.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';

class Round extends Entity<Round> {
  int? id;
  final String nome;
  final int tempo;
  final bool som;
  int? programacaoId;
  Round(
      {required this.nome,
      required this.id,
      required this.tempo,
      required this.som,
      required this.programacaoId});

  Round.basico({required this.nome, required this.tempo, required this.som});

  @override
  Round fromMap(Map<String, dynamic> jsonMap) {
    return Round.fromJson(jsonMap);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tempo': tempo,
      'som': som,
      'programacao_id': programacaoId
    };
  }

  static Round fromJson(Map<String, dynamic> map) {
    return Round(
        nome: map['nome'] as String,
        id: map['id'] as int,
        tempo: map['tempo'] as int,
        som: map['som'] as bool,
        programacaoId: map['programacao_id'] as int);
  }
}
