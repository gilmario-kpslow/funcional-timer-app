import 'package:cristimer/core/modelos/entity.dart';

class Round extends Entity<Round> {
  int? id;
  final String nome;
  String? descricao;
  final int tempo;
  final bool somInicio;
  bool? somTermino;
  int? delayTermino;
  int? programacaoId;
  int? ordem;

  Round(
      {required this.nome,
      required this.descricao,
      required this.id,
      required this.tempo,
      required this.ordem,
      required this.somInicio,
      required this.somTermino,
      required this.delayTermino,
      required this.programacaoId});

  Round.basico(
      {required this.nome,
      this.descricao,
      required this.tempo,
      required this.somInicio,
      this.somTermino = false,
      this.delayTermino = 0,
      this.ordem = 0});

  @override
  Round fromMap(Map<String, dynamic> jsonMap) {
    return Round.fromJson(jsonMap);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'tempo': tempo,
      'somInicio': somInicio,
      'somTermino': somTermino,
      'delayTermino': delayTermino,
      'programacao_id': programacaoId,
      'ordem': ordem,
    };
  }

  static Round fromJson(Map<String, dynamic> map) {
    return Round(
        nome: map['nome'] as String,
        descricao: map['descricao'] as String,
        id: map['id'] as int,
        tempo: map['tempo'] as int,
        ordem: map['ordem'] as int,
        somInicio: parseBool(map['somInicio'] as int),
        somTermino: parseBool(map['somTermino'] as int),
        delayTermino: map['delayTermino'] as int,
        programacaoId: map['programacao_id'] as int);
  }

  static parseBool(int value) {
    if (value > 0) {
      return true;
    }
    return false;
  }
}
