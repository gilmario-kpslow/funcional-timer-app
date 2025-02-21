import 'package:cristimer/core/database/databaseutil.dart';
import 'package:cristimer/core/modelos/serie.dart';
import 'package:cristimer/core/service/exercicio_service.dart';
import 'package:sqflite/sqflite.dart';

class SerieService {
  ExercicioService exercicioService = ExercicioService();

  get(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    var m = await db.query('serie', where: "id =?", whereArgs: [id]);
    return Serie(0, 0, "", "", 0).fromMap(m[0]);
  }

  salvar(Serie entity) async {
    final db = await DatabaseUtil.getDatabase();
    await db.insert(
      'serie',
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Serie>> getLista() async {
    final db = await DatabaseUtil.getDatabase();
    final List<Map<String, dynamic>> lista = await db.query('serie');

    return lista.map((Map<String, dynamic> m) {
      return Serie(0, 0, "", "", 0).fromMap(m);
    }).toList();
  }

  Future<List<Serie>> getListaPorRotina(int? idRotina) async {
    final db = await DatabaseUtil.getDatabase();
    final List<Map<String, dynamic>> lista =
        await db.query('serie', where: "id_rotina=?", whereArgs: [idRotina]);

    return lista.map((Map<String, dynamic> m) {
      return Serie(0, 0, "", "", 0).fromMap(m);
    }).toList();
  }

  delete(int? id) async {
    final db = await DatabaseUtil.getDatabase();
    await exercicioService.deleteByRotina(id);
    await db.delete("serie", where: "id=?", whereArgs: [id]);
  }
}
