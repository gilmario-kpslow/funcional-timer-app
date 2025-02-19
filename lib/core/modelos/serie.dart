import 'package:cristimer/core/modelos/entity.dart';

class Serie extends Entity<Serie> {
  final String nome;
  final String? descricao;
  int? id;
  int? rotinaId;
  Serie(this.id, this.rotinaId, this.nome, this.descricao);

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
    };
  }

  static Serie fromJson(Map<String, dynamic> map) {
    return Serie(
        map['id'] as int, //
        map['rotina_id'] as int,
        map['nome'] as String,
        map['descricao'] as String);
  }
}
