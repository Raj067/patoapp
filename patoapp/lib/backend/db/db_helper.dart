import 'package:patoapp/backend/models/shedules.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "shedule";
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}shedule.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        // print("Creating New one");
        return db.execute("CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, description TEXT, dateEvent STRING, "
            "startTime STRING, endTime STRING, isCompleted INTEGER)");
      });
    } catch (e) {
      // print(e);
    }
  }

  static Future<int> insertDb(SheduleModel shedule) async {
    // print("insert function called");
    return await _db?.insert(_tableName, shedule.toJson()) ?? 0;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    // print("query func completed");
    return await _db!.query(_tableName);
  }
}
