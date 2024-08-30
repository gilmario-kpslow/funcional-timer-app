import 'package:funcional_timer_app/core/database/databaseutil.dart';
import 'package:funcional_timer_app/core/modelos/programacao.dart';
import 'package:sqflite/sqflite.dart';

class ProgramacaoService {
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
}
