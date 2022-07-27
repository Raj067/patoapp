import 'package:patoapp/backend/models/product_list.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperProduct {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "product";
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}db_product.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        // print("-------------- Creating customer database ------------");
        return db.execute("CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY,  shopId INTEGER,"
            "isService INTEGER, productUnit STRING, "
            "productName STRING, quantity INTEGER, "
            "purchasesPrice INTEGER, sellingPrice INTEGER, stockLevel INTEGER, "
            "supplierName STRING, supplierContact STRING, thumbnail STRING, "
            "createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
      });
    } catch (e) {
      // print(e);
    }
  }

// Create new item (journal)
  static Future<int> insertDb(SingleProduct product) async {
    return await _db?.insert(_tableName, product.toJson()) ?? 0;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static getItem(SingleProduct product) async {
    int id = product.id;
    return await _db!
        .query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(SingleProduct product) async {
    int id = product.id;
    return await _db?.update(_tableName, product.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        0;
  }

  static Future<void> deleteItem(SingleProduct product) async {
    int id = product.id;
    try {
      await _db?.delete(_tableName, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      // print("Something went wrong when deleting an item: $err");
    }
  }
}
