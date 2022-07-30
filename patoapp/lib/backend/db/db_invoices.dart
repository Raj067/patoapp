import 'package:patoapp/backend/models/invoice_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperInvoice {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "invoice";
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}dbs_invoices.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        // print("-------------- Creating invoice database ------------");
        return db.execute("CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY, shopId INTEGER, customerId INTEGER, "
            "discount INTEGER, amountReceived INTEGER, invoiceNo STRING, "
            "dueDate STRING, description STRING, items TEXT, fullName STRING, "
            "createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
      });
    } catch (e) {
      // print(e);
    }
  }

// Create new item (journal)
  static Future<int> insertDb(SingleInvoice invoice) async {
    return await _db?.insert(_tableName, invoice.toJson()) ?? 0;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName, orderBy: "-id");
  }

  static getItem(SingleInvoice invoice) async {
    int id = invoice.id;
    return await _db!
        .query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(SingleInvoice invoice) async {
    int id = invoice.id;
    return await _db?.update(_tableName, invoice.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        0;
  }

  static Future<void> deleteItem(SingleInvoice invoice) async {
    int id = invoice.id;
    try {
      await _db?.delete(_tableName, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      // print("Something went wrong when deleting an item: $err");
    }
  }
}
