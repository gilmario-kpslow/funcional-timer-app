class Exercicio {
  int? id;
  int? rotinaId;
  final String nome;
  final String descricao;
  final int tempo;
  final int delayTermino;
  final int delayInicio;
  final String somInicio;
  final String somPreTermino;
  final String somTermino;
  int ordem;

  Exercicio({
    required this.id,
    required this.rotinaId,
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

  Exercicio.basico(
      {required this.nome,
      required this.descricao,
      required this.tempo,
      this.delayInicio = 0,
      this.delayTermino = 0,
      this.somInicio = "",
      this.somPreTermino = "",
      this.somTermino = "",
      this.ordem = 0});

  static Exercicio fromMap(Map<String, dynamic> jsonMap) {
    return Exercicio.fromJson(jsonMap);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rotina_id': rotinaId,
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

  static Exercicio fromJson(Map<String, dynamic> map) {
    return Exercicio(
      id: map['id'] as int,
      rotinaId: map['rotina_id'] as int,
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
