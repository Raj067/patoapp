import 'package:patoapp/backend/models/notification.dart';
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
      String path = '${await getDatabasesPath()}shedules.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        print("Creating New one");
        return db.execute("CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, description TEXT, dateEvent STRING, "
            "startTime STRING, endTime STRING, isCompleted BOOL)");
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertDb(NotificationModel shedule) async {
    print("insert function called");
    return await _db?.insert(_tableName, shedule.toJson()) ?? 0;
  }
}
