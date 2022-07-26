import 'package:patoapp/backend/models/profile_details.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperProfile {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "profile";
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}profile.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        // print("-------------- Creating customer database ------------");
        return db.execute("CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY, "
            "profileName STRING, profileAddress STRING, "
            "profileEmail STRING, instagramName STRING,  "
            "profileType STRING, profileCategory STRING, "
            "instagramSlogan STRING, "
            "createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
      });
    } catch (e) {
      // print(e);
    }
  }

// Create new item (journal)
  static Future<int> insertDb(ProfileData profile) async {
    return await _db?.insert(_tableName, profile.toJson()) ?? 0;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static getItem(ProfileData profile) async {
    int id = profile.id;
    return await _db!
        .query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(ProfileData profile) async {
    int id = profile.id;
    return await _db?.update(_tableName, profile.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        0;
  }

  static Future<void> deleteItem(ProfileData profile) async {
    int id = profile.id;
    try {
      await _db?.delete(_tableName, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      // print("Something went wrong when deleting an item: $err");
    }
  }
}
