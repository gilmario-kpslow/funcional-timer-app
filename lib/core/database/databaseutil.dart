import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseUtil {
  static Future<Database> getDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'funcional.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE PROGRAMACAO(id INTEGER PRIMARY KEY, name TEXT, descricao TEXT)',
        );
      },
      version: 1,
    );

    return database;
  }
}
