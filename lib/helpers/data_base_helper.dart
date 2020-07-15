import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DataBaseHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await sql
        .getDatabasesPath(); //the path where you may store you data (folder)
    final sqlDB = await sql.openDatabase(
      //opens or creates (if it doesn't exist yet)
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        //if the file it's not yet created, this will run; db = data base, version = the version of you data base
        return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)', //names are commands of SQL
        );
      },
      version: 1, //we work with 1 version
    );
    await sqlDB.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,//if we try to insert data that already exist, we will replace the old one
    );
  }
}
