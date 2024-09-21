import 'package:cristimer/core/database/databaseutil.dart';
import 'package:cristimer/core/modelos/round.dart';
import 'package:sqflite/sqflite.dart';

class RoundService {
  static const String table = "ROUND";

  salvar(Round entity) async {
    final db = await DatabaseUtil.getDatabase();
    if (entity.ordem == 0) {
      var ordem = await getOrder(entity.programacaoId);

      if (ordem.first.row[0] == null) {
        entity.ordem = 1;
      } else {
        entity.ordem = ordem.first.row[0] + 1;
      }
    }
    print(entity.toMap());

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
      return Round.fromMap(m);
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

  deleteByPrograma(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    await db.delete(table, where: "programacao_id=?", whereArgs: [id]);
  }
}
