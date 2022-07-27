import 'package:patoapp/backend/models/customer_list.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperCustomer {
  static Database? _db;
  static const int _version = 2;
  static const String _tableName = "customers";
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}db_customer.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        // print("-------------- Creating customer database ------------");
        return db.execute("CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY, shopId INTEGER,"
            "amount INTEGER, fullName STRING, email STRING, "
            "address STRING, phoneNumber STRING, financialData TEXT,"
            "createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
      });
    } catch (e) {
      // print(e);
    }
  }

// Create new item (journal)
  static Future<int> insertDb(SingleCustomer customer) async {
    return await _db?.insert(_tableName, customer.toJson()) ?? 0;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName, orderBy: "-id");
  }

  static getItem(SingleCustomer customer) async {
    int id = customer.id;
    return await _db!
        .query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(SingleCustomer customer) async {
    int id = customer.id;
    return await _db?.update(_tableName, customer.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        0;
  }

  static Future<void> deleteItem(SingleCustomer customer) async {
    int id = customer.id;
    try {
      await _db?.delete(_tableName, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      // print("Something went wrong when deleting an item: $err");
    }
  }
}
