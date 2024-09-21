class Round {
  int? id;
  int? programacaoId;
  final String nome;
  final String descricao;
  final int tempo;
  final int delayTermino;
  final int delayInicio;
  final String somInicio;
  final String somPreTermino;
  final String somTermino;
  int ordem;

  Round({
    required this.id,
    required this.programacaoId,
    required this.nome,
    required this.descricao,
    required this.tempo,
    required this.delayTermino,
    required this.delayInicio,
    required this.somInicio,
    required this.somPreTermino,
    required this.somTermino,
    required this.ordem,
  });

  Round.basico(
      {required this.nome,
      required this.descricao,
      required this.tempo,
      this.delayInicio = 0,
      this.delayTermino = 0,
      this.somInicio = "",
      this.somPreTermino = "",
      this.somTermino = "",
      this.ordem = 0});

  static Round fromMap(Map<String, dynamic> jsonMap) {
    return Round.fromJson(jsonMap);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'programacao_id': programacaoId,
      'nome': nome,
      'descricao': descricao,
      'tempo': tempo,
      'delay_termino': delayTermino,
      'delay_inicio': delayInicio,
      'som_inicio': somInicio,
      'som_pre_termino': somPreTermino,
      'som_termino': somTermino,
      'ordem': ordem,
    };
  }

  static Round fromJson(Map<String, dynamic> map) {
    return Round(
      id: map['id'] as int,
      programacaoId: map['programacao_id'] as int,
      nome: map['nome'] as String,
      descricao: map['descricao'] as String,
      tempo: map['tempo'] as int,
      delayTermino: map['delay_termino'] as int,
      delayInicio: map['delay_inicio'] as int,
      somInicio: map['som_inicio'] ?? "",
      somPreTermino: map['som_pre_termino'] ?? "",
      somTermino: map['som_termino'] ?? "",
      ordem: map['ordem'] as int,
    );
  }

  static parseBool(int value) {
    if (value > 0) {
      return true;
    }
    return false;
  }
}
