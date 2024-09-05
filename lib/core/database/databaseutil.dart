import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseUtil {
  static Future<Database> getDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'funcional.db'),
      version: 1,
    );

    return database;
  }

  static Future<void> recriarBanco() async {
    final db = await getDatabase();

    await db.execute(
      'CREATE TABLE PROGRAMACAO(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, descricao TEXT, status TEXT)',
    );
    await db.execute(
      'CREATE TABLE ROUND( ' +
          ' id INTEGER PRIMARY KEY AUTOINCREMENT, programacao_id INTEGER NOT NULL, nome TEXT NOT NULL, descricao TEXT, tempo INTEGER NOT NULL, delayTermino INTEGER, somTermino boolean, somInicio boolean, ordem INTEGER not null)',
    );
  }

  static Future<void> removerBanco() async {
    final db = await getDatabase();
    await db.execute(
      'DROP TABLE ROUND;',
    );
    await db.execute(
      'DROP TABLE PROGRAMACAO;',
    );
  }
}
