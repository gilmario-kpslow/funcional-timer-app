import 'package:cristimer/core/database/databaseutil.dart';
import 'package:cristimer/core/modelos/exercicio.dart';
import 'package:cristimer/core/util/table_const.dart';
import 'package:sqflite/sqflite.dart';

class ExercicioService {
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
      tableExercicio,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Exercicio>> getLista(int? rotinaId) async {
    final db = await DatabaseUtil.getDatabase();
    final List<Map<String, dynamic>> lista =
        await db.query(tableExercicio, orderBy: "nome");

    return lista.map((Map<String, dynamic> m) {
      return Exercicio.fromMap(m);
    }).toList();
  }

  Future<void> setOrdem(int? id, int ordem) async {
    // final db = await DatabaseUtil.getDatabase();
    // await db.update(tableExercicio, {'ordem': ordem},
    //     where: 'id= ?', whereArgs: [id]);
  }

  Future<void> ajuste(int? id) async {
    final db = await DatabaseUtil.getDatabase();

    await db.rawUpdate(
        "UPDATE $tableExercicio SET ORDEM = id WHERE rotina_id = ? ", [id]);
  }

  getOrder(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    return await db.rawQuery(
        "SELECT COUNT(*) as ordem FROM $tableExercicio WHERE rotina_id=?",
        [id]);
  }

  delete(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    await db.delete(tableExercicio, where: 'id= ?', whereArgs: [id]);
  }

  deleteByRotina(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    await db.delete(tableExercicio, where: "rotina_id=?", whereArgs: [id]);
  }

  deleteBySerie(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    await db.delete(tableExercicio, where: "serie_id=?", whereArgs: [id]);
  }
}
