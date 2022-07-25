import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperBusiness {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "business";
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}business.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        // print("-------------- Creating customer database ------------");
        return db.execute("CREATE TABLE $_tableName("
            "id STRING PRIMARY KEY, "
            "amount INTEGER, discount INTEGER, date TIMESTAMP, "
            "receipt STRING, isCashSale INTEGER, details TEXT,"
            "isExpenses INTEGER, isPaymentIn INTEGER, isPaymentOut INTEGER, "
            "isInvoice INTEGER, isPurchases INTEGER, name STRING, "
            "description STRING, "
            "createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
      });
    } catch (e) {
      // print(e);
    }
  }

// Create new item (journal)
  static Future<int> insertDb(FinancialData business) async {
    return await _db?.insert(_tableName, business.toJson()) ?? 0;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName, orderBy: "-id");
  }

  static getItem(FinancialData business) async {
    String id = business.id;
    return await _db!
        .query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(FinancialData business) async {
    String id = business.id;
    return await _db?.update(_tableName, business.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        0;
  }

  static Future<void> deleteItem(FinancialData business) async {
    String id = business.id;
    try {
      await _db?.delete(_tableName, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      // print("Something went wrong when deleting an item: $err");
    }
  }
}
