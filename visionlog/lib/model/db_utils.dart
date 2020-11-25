import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'dream_manager.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE dream_items(id INTEGER PRIMARY KEY, datetime TEXT, title TEXT, message TEXT, moodFeel TEXT, lucid TEXT, nightmare TEXT, recurring TEXT, continuous TEXT)');
      },
      version: 1,
    );
    return database;
  }
}
