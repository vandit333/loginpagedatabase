import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class data
{
  Future<Database>createDatabase()
  async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE form (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT , number TEXT,email TEXT ,password TEXT,repassword TEXT, fav TEXT)');
        });
    return database;
  }
}
