import 'package:cristimer/core/modelos/entity.dart';

class Rotina extends Entity<Rotina> {
  final String nome;
  final String? descricao;
  final String status;
  int? id;
  Rotina(this.id, this.nome, this.descricao, this.status);
  Rotina.basico(this.nome, this.descricao, this.status);

  @override
  Rotina fromMap(Map<String, dynamic> jsonMap) {
    return Rotina.fromJson(jsonMap);
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

  static Rotina fromJson(Map<String, dynamic> map) {
    return Rotina(
        map['id'] as int, //
        map['nome'] as String,
        map['descricao'] as String,
        map['status'] as String);
  }
}

const String statusAtivo = "ATIVO";
const String statusExcluido = "EXCLUIDO";
