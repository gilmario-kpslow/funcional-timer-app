import 'package:cristimer/core/database/databaseutil.dart';
import 'package:cristimer/core/modelos/serie.dart';
import 'package:cristimer/core/service/exercicio_service.dart';
import 'package:cristimer/core/util/table_const.dart';
import 'package:sqflite/sqflite.dart';

class SerieService {
  ExercicioService exercicioService = ExercicioService();

  get(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    var m = await db.query(tableSerie, where: "id =?", whereArgs: [id]);
    return Serie(0, 0, "", "", 0).fromMap(m[0]);
  }

  salvar(Serie entity) async {
    final db = await DatabaseUtil.getDatabase();
    var id = await db.insert(
      tableSerie,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Serie>> getLista() async {
    final db = await DatabaseUtil.getDatabase();
    final List<Map<String, dynamic>> lista = await db.query(tableSerie);

    return lista.map((Map<String, dynamic> m) {
      return Serie(0, 0, "", "", 0).fromMap(m);
    }).toList();
  }

  Future<List<Serie>> getListaPorRotina(int? idRotina) async {
    final db = await DatabaseUtil.getDatabase();
    final List<Map<String, dynamic>> lista =
        await db.query(tableSerie, where: "rotina_id=?", whereArgs: [idRotina]);

    return lista.map((Map<String, dynamic> m) {
      return Serie(0, 0, "", "", 0).fromMap(m);
    }).toList();
  }

  delete(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    // await exercicioService.deleteBySerie(id);
    await db.delete(tableSerie, where: "id=?", whereArgs: [id]);
  }
}
