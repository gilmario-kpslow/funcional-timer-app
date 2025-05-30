import 'package:cristimer/core/database/databaseutil.dart';
import 'package:cristimer/core/modelos/rotina.dart';
import 'package:cristimer/core/service/exercicio_service.dart';
import 'package:cristimer/core/util/table_const.dart';
import 'package:sqflite/sqflite.dart';

class RotinaService {
  ExercicioService exercicioService = ExercicioService();

  get(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    var m = await db.query(tableRotina, where: "id =?", whereArgs: [id]);
    return Rotina(0, "", "", "").fromMap(m[0]);
  }

  salvar(Rotina entity) async {
    final db = await DatabaseUtil.getDatabase();
    await db.insert(
      tableRotina,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Rotina>> getLista() async {
    final db = await DatabaseUtil.getDatabase();
    final List<Map<String, dynamic>> lista = await db.query(tableRotina);

    return lista.map((Map<String, dynamic> m) {
      return Rotina(0, "", "", "").fromMap(m);
    }).toList();
  }

  delete(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    await exercicioService.deleteByRotina(id);
    await db.delete(tableRotina, where: "id=?", whereArgs: [id]);
  }
}
