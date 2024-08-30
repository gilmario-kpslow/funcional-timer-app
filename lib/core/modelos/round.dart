import 'package:funcional_timer_app/core/modelos/entity.dart';

class Round extends Entity<Round> {
  int? id;
  final String nome;
  final int tempo;
  final bool somInicio;
  bool? somTermino;
  int? delayTermino;
  int? programacaoId;

  Round(
      {required this.nome,
      required this.id,
      required this.tempo,
      required this.somInicio,
      required this.somTermino,
      required this.delayTermino,
      required this.programacaoId});

  Round.basico(
      {required this.nome,
      required this.tempo,
      required this.somInicio,
      this.somTermino = false,
      this.delayTermino = 0});

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
      'som': somInicio,
      'programacao_id': programacaoId
    };
  }

  static Round fromJson(Map<String, dynamic> map) {
    return Round(
        nome: map['nome'] as String,
        id: map['id'] as int,
        tempo: map['tempo'] as int,
        somInicio: map['somInicio'] as bool,
        somTermino: map['somTermino'] as bool,
        delayTermino: map['delayTermino'] as int,
        programacaoId: map['programacao_id'] as int);
  }
}
