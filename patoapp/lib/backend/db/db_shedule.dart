import 'package:patoapp/backend/models/shedules.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperShedule {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "shedule";
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}db_shedules.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        // print("Creating New one");
        return db.execute("CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY, "
            "title STRING, description TEXT, dateEvent STRING, "
            "color INTEGER, repeat STRING, remind INTEGER,  createdAt STRING, "
            "startTime STRING, endTime STRING, isCompleted INTEGER)");
      });
    } catch (e) {
      // print(e);
    }
  }

// Create new item (journal)
  static Future<int> insertDb(SheduleModel shedule) async {
    return await _db?.insert(_tableName, shedule.toJson()) ?? 0;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static getItem(int id) async {
    return await _db!
        .query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(SheduleModel shedule) async {
    int id = shedule.id;
    return await _db?.update(_tableName, shedule.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        0;
  }

  static Future<void> deleteItem(SheduleModel shedule) async {
    int id = shedule.id;
    try {
      await _db?.delete(_tableName, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      // print("Something went wrong when deleting an item: $err");
    }
  }
}
