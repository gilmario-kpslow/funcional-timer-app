import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseUtil {
  static Future<Database> getDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'funcional.db'),
      onCreate: (db, version) => DatabaseUtil.recriarBanco(db, version),
      version: 2,
    );
    return database;
  }

  static Future<void> recriarBanco(db, int version) async {
    await db.execute(
      'CREATE TABLE ROTINA(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, descricao TEXT, status TEXT)',
    );

    await db.execute(
        'CREATE TABLE SERIE( id INTEGER PRIMARY KEY AUTOINCREMENT, rotina_id INTEGER NOT NULL, nome TEXT NOT NULL, DESCRICAO TEXT)');

    await db.execute(
      'CREATE TABLE EXERCICIO( id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, descricao TEXT, tempo INTEGER NOT NULL, delay_termino INTEGER DEFAULT 0, delay_inicio INTEGER DEFAULT 0, som_inicio TEXT, som_pre_termino TEXT, som_termino TEXT, ordem INTEGER not null)',
    );

    await db.execute(
        'CREATE TABLE ROTINA_HISTORICO( id INTEGER PRIMARY KEY AUTOINCREMENT, rotina_id INTEGER NOT NULL, data_execucao DATETIME NOT NULL)');

    await db.execute(
      'CREATE TABLE EXERCICIO_SERIE(id INTEGER PRIMARY KEY AUTOINCREMENT, serie_id INTEGER NOT NULL, exercicio_id INTEGER NOT NULL, repeticoes INTEGER NOT NULL)',
    );

    await db.execute(
      'CREATE TABLE ROTINA_SERIE(id INTEGER PRIMARY KEY AUTOINCREMENT, serie_id INTEGER NOT NULL, rotina_id INTEGER NOT NULL, repeticoes INTEGER NOT NULL)',
    );
  }

  static Future<void> removerBanco() async {
    final db = await getDatabase();
    await db.execute(
      'DROP TABLE EXERCICIO_SERIE;',
    );

    await db.execute(
      'DROP TABLE ROTINA_SERIE;',
    );

    await db.execute(
      'DROP TABLE EXERCICIO;',
    );
    await db.execute(
      'DROP TABLE ROTINA_HISTORICO;',
    );

    await db.execute(
      'DROP TABLE ROTINA;',
    );

    await db.execute(
      'DROP TABLE SERIE;',
    );
  }
}
