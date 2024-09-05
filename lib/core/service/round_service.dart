import 'package:funcional_timer_app/core/database/databaseutil.dart';
import 'package:funcional_timer_app/core/modelos/round.dart';
import 'package:sqflite/sqflite.dart';

class RoundService {
  static const String table = "ROUND";

  salvar(Round entity) async {
    final db = await DatabaseUtil.getDatabase();
    if (entity.ordem == null || entity.ordem == 0) {
      var ordem = await getOrder(entity.programacaoId);

      if (ordem.first.row[0] == null) {
        entity.ordem = 1;
      } else {
        entity.ordem = ordem.first.row[0] + 1;
      }
    }
    await db.insert(
      table,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Round>> getLista(int? idPrograma) async {
    final db = await DatabaseUtil.getDatabase();
    final List<Map<String, dynamic>> lista = await db.query(table,
        orderBy: "ordem", where: "programacao_id=?", whereArgs: [idPrograma]);

    return lista.map((Map<String, dynamic> m) {
      return Round.basico(
              nome: "",
              somInicio: false,
              tempo: 0,
              delayTermino: 0,
              somTermino: false)
          .fromMap(m);
    }).toList();
  }

  Future<void> setOrdem(int? id, int ordem) async {
    final db = await DatabaseUtil.getDatabase();
    await db.update(table, {'ordem': ordem}, where: 'id= ?', whereArgs: [id]);
  }

  Future<void> ajuste(int? id) async {
    final db = await DatabaseUtil.getDatabase();

    await db.rawUpdate(
        "UPDATE $table SET ORDEM = id WHERE programacao_id = ? ", [id]);
  }

  getOrder(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    return await db.rawQuery(
        "SELECT COUNT(*) as ordem FROM $table WHERE programacao_id=?", [id]);
  }

  delete(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    await db.delete(table, where: 'id= ?', whereArgs: [id]);
  }
}
