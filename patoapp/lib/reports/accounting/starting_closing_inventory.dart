import 'package:get/get.dart';
import 'package:patoapp/backend/controllers/business_controller.dart';

getAllTransaction() {
  List<Product> dataReq = [];
  var data = Get.put(BusinessController()).allFinancialData;
  for (var dx in data) {
    if (dx.isCashSale || dx.isInvoice || dx.isPurchases) {
      if (dx.isInvoice) {
      } else {
        for (Map dm in dx.details) {
          dataReq.add(Product(
            date: DateTime.parse(
              dm['date'],
            ),
            productId: dm['id'],
            quantity: dm['quantity'],
            purchasesPrice: 0,
          ));
        }
      }
    }
  }
}

class Product {
  int productId;
  DateTime date;
  int quantity;
  int purchasesPrice;
  Product({
    required this.productId,
    required this.date,
    required this.quantity,
    required this.purchasesPrice,
  });
}

class Inventory {
  DateTime startingDate;
  DateTime closingDate;
  List<Product> data; // list of all transactions
  Inventory({
    required this.data,
    required this.startingDate,
    required this.closingDate,
  });

  double getClosingInventory(Product reference) {
    /* for single product */

    double qty = 0;
    for (var dx in data) {
      if (dx.productId == reference.productId) {
        if (dx.date.isAfter(startingDate) && dx.date.isBefore(closingDate)) {
          qty += dx.quantity;
        }
      }
    }
    qty -= reference.quantity;

    return qty * reference.purchasesPrice;
  }
}
