import 'package:cristimer/core/database/databaseutil.dart';
import 'package:cristimer/core/modelos/programacao.dart';
import 'package:cristimer/core/service/round_service.dart';
import 'package:sqflite/sqflite.dart';

class ProgramacaoService {
  RoundService roundService = RoundService();

  get(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    var m = await db.query('programacao', where: "id =?", whereArgs: [id]);
    return Programacao(0, "", "", "").fromMap(m[0]);
  }

  salvar(Programacao entity) async {
    final db = await DatabaseUtil.getDatabase();
    await db.insert(
      'programacao',
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Programacao>> getLista() async {
    final db = await DatabaseUtil.getDatabase();
    final List<Map<String, dynamic>> lista = await db.query('programacao');

    return lista.map((Map<String, dynamic> m) {
      return Programacao(0, "", "", "").fromMap(m);
    }).toList();
  }

  delete(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    await roundService.deleteByPrograma(id);
    await db.delete("programacao", where: "id=?", whereArgs: [id]);
  }
}
