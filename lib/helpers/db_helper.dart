import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database(String dbName) async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, dbName),
      onCreate: (db, version) {
        switch (dbName) {
          case 'keywords.db':
            return db.execute('CREATE TABLE keywords(keyword TEXT)');
            break;
          case 'savedOffers.db':
            return db.execute(
                'CREATE TABLE savedOffers(title TEXT, date TEXT, link TEXT, place TEXT, source TEXT)');
          case 'scraperUrl.db':
            return db.execute('CREATE TABLE scraperUrl(url TEXT)');
          default:
        }
      },
      version: 1,
    );
  }

  static Future<void> insert(
      String dbName, String table, Map<String, Object> data) async {
    final db = await DBHelper.database(dbName);
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(
      String dbName, String table, String where, List<Object> whereArgs) async {
    final db = await DBHelper.database(dbName);
    db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  static Future<void> drop(String dbName, String table) async {
    final db = await DBHelper.database(dbName);
    db.delete(table);
  }

  static Future<List<Map<String, dynamic>>> getData(
      String dbName, String table) async {
    final db = await DBHelper.database(dbName);

    return db.query(table);
  }
}
