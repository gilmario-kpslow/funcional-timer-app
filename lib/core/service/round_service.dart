import 'package:funcional_timer_app/core/database/databaseutil.dart';
import 'package:funcional_timer_app/core/modelos/round.dart';
import 'package:sqflite/sqflite.dart';

class RoundService {
  salvar(Round entity) async {
    final db = await DatabaseUtil.getDatabase();
    await db.insert(
      'round',
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Round>> getLista(int idPrograma) async {
    final db = await DatabaseUtil.getDatabase();
    final List<Map<String, dynamic>> lista = await db.query(
      'round',
    );

    return lista.map((Map<String, dynamic> m) {
      return Round.basico(nome: "", som: false, tempo: 0).fromMap(m);
    }).toList();
  }
}
