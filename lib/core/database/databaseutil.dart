import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseUtil {
  static Future<Database> getDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'funcional.db'),
      onCreate: (db, version) => DatabaseUtil._recriarBanco(db, version),
      version: 2,
    );
    return database;
  }

  static Future<void> recriarBanco() async {
    final db = await getDatabase();

    _recriarBanco(db, 0);
  }

  static Future<void> _recriarBanco(db, int version) async {
    await db.execute(
      'create table rotina(id integer primary key autoincrement, nome text, descricao text, status text)',
    );

    await db.execute(
        'create table serie( id integer primary key autoincrement, rotina_id integer not null, nome text not null, descricao text, repeticoes not null, som_inicio text, som_pre_termino text, som_termino text)');

    await db.execute(
      'create table exercicio( id integer primary key autoincrement, nome text not null, descricao text)',
    );

    await db.execute(
      'create table serie_exercicio( id integer primary key autoincrement, id_serie integer not null, tempo integer not null, delay_termino integer default 0, delay_inicio integer default 0, som_inicio text, som_pre_termino text, som_termino text, ordem integer not null)',
    );

    await db.execute(
        'create table historico_execucao( id integer primary key autoincrement, rotina_id integer not null, data_execucao datetime not null)');
  }

  static Future<void> removerBanco() async {
    final db = await getDatabase();

    await db.execute(
      'DROP TABLE IF EXISTS historico_execucao;',
    );

    await db.execute(
      'DROP TABLE IF EXISTS serie_exercicio;',
    );

    await db.execute(
      'DROP TABLE IF EXISTS exercicio;',
    );
    await db.execute(
      'DROP TABLE IF EXISTS serie;',
    );

    await db.execute(
      'DROP TABLE IF EXISTS rotina;',
    );
  }
}
