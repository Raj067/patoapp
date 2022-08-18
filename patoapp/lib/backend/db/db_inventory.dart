import 'package:patoapp/backend/models/inventory_tracking.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperInventory {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "inventory";
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}db_inventory.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        // print("-------------- Creating inventory database ------------");
        return db.execute("CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY, shopId INTEGER,"
            "quantityAdded INTEGER, purchasesPrice INTEGER, "
            "createdAt STRING, updatedAt STRING)");
      });
    } catch (e) {
      // print(e);
      // print('data base not created');
    }
  }

// Create new item (journal)
  static Future<int> insertDb(InventoryTracking inventory) async {
    return await _db?.insert(_tableName, inventory.toJson()) ?? 0;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName, orderBy: "-id");
  }

  static getItem(InventoryTracking inventory) async {
    int id = inventory.id;
    return await _db!
        .query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(InventoryTracking inventory) async {
    int id = inventory.id;
    return await _db?.update(_tableName, inventory.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        0;
  }

  static Future<void> deleteItem(InventoryTracking inventory) async {
    int id = inventory.id;
    try {
      await _db?.delete(_tableName, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      // print("Something went wrong when deleting an item: $err");
    }
  }
}
