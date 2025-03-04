import 'package:cristimer/core/database/databaseutil.dart';
import 'package:cristimer/core/modelos/exercicio.dart';
import 'package:sqflite/sqflite.dart';

class ExercicioService {
  static const String table = "EXERCICIO";

  salvar(Exercicio entity) async {
    final db = await DatabaseUtil.getDatabase();
    if (entity.ordem == 0) {
      var ordem = await getOrder(entity.rotinaId);

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

  Future<List<Exercicio>> getLista(int? rotinaId) async {
    final db = await DatabaseUtil.getDatabase();
    final List<Map<String, dynamic>> lista =
        await db.query(table, orderBy: "nome");

    return lista.map((Map<String, dynamic> m) {
      return Exercicio.fromMap(m);
    }).toList();
  }

  Future<void> setOrdem(int? id, int ordem) async {
    final db = await DatabaseUtil.getDatabase();
    await db.update(table, {'ordem': ordem}, where: 'id= ?', whereArgs: [id]);
  }

  Future<void> ajuste(int? id) async {
    final db = await DatabaseUtil.getDatabase();

    await db
        .rawUpdate("UPDATE $table SET ORDEM = id WHERE rotina_id = ? ", [id]);
  }

  getOrder(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    return await db.rawQuery(
        "SELECT COUNT(*) as ordem FROM $table WHERE rotina_id=?", [id]);
  }

  delete(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    await db.delete(table, where: 'id= ?', whereArgs: [id]);
  }

  deleteByRotina(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    await db.delete(table, where: "rotina_id=?", whereArgs: [id]);
  }
}
