import 'package:cristimer/core/modelos/entity.dart';

class Serie extends Entity<Serie> {
  final String nome;
  final String? descricao;
  int? id;
  int? rotinaId;
  int repeticoes;
  Serie(this.id, this.rotinaId, this.nome, this.descricao, this.repeticoes);

  @override
  Serie fromMap(Map<String, dynamic> jsonMap) {
    return Serie.fromJson(jsonMap);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rotina_id': rotinaId,
      'nome': nome,
      'descricao': descricao,
      'repeticoes': repeticoes,
    };
  }

  static Serie fromJson(Map<String, dynamic> map) {
    print(map['descricao']);
    print(map);
    return Serie(
        map['id'] as int, //
        map['rotina_id'] as int,
        map['nome'] as String,
        map['descricao'] as String,
        map['repeticoes'] as int);
  }
}
