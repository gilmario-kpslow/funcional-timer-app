import 'package:funcional_timer_app/core/modelos/entity.dart';

class Programacao extends Entity<Programacao> {
  final String nome;
  final String descricao;
  final String status;
  int? id;
  Programacao(this.id, this.nome, this.descricao, this.status);
  Programacao.basico(this.nome, this.descricao, this.status);

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
      'status': status,
    };
  }

  static Programacao fromJson(Map<String, dynamic> map) {
    return Programacao(
        map['id'] as int, //
        map['nome'] as String,
        map['descricao'] as String,
        map['status'] as String);
  }
}

const String STATUS_ATIVO = "ATIVO";
const String STATUS_EXCLUIDO = "EXCLUIDO";
