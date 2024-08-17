import 'package:funcional_timer_app/core/modelos/entity.dart';
import 'package:funcional_timer_app/core/modelos/round.dart';

class Programacao extends Entity<Programacao> {
  final String nome;
  final String descricao;
  final int id;
  // final List<Round> rounds;
  // Programacao(this.id, this.nome, this.descricao, this.rounds);
  Programacao(this.id, this.nome, this.descricao);

  @override
  Programacao fromMap(Map<String, dynamic> jsonMap) {
    return Programacao.fromJson(jsonMap);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      // 'rounds': rounds.map((i) => i.toJson()).toList()
    };
  }

  static Programacao fromJson(Map<String, dynamic> map) {
    return Programacao(
        map['id'] as int, map['nome'] as String, map['descricao'] as String);
    // map['rounds'].map((i) => Round.fromJson(i)).toList().cast<Round>());
  }
}
