// Note: only post changes to the backend where necessary, otherwise not sending them,
import 'package:patoapp/backend/funcs/misc.dart';

class SingleProduct {
  String productName;
  String thumbnail;
  int stockLevel = 0;
  int quantity;
  int sellingPrice;
  int purchasesPrice;
  var supplierName = '';
  var supplierContact = '';
  String supplierEmail = '';
  int productCode = 0;
  int totalItemsSold;
  int addedToCart = 0;
  bool isAddedToCartAutomatic = false;
  int id;
  int shopId;
  String productUnit = '';
  bool isService = false;

  SingleProduct({
    required this.productName,
    required this.sellingPrice,
    required this.purchasesPrice,
    required this.id,
    required this.shopId,
    required this.quantity,
    required this.productUnit,
    required this.isService,
    this.stockLevel = 0,
    this.thumbnail = "",
    this.totalItemsSold = 90,
    this.supplierName = '',
    this.supplierContact = '',
    this.addedToCart = 0,
    this.isAddedToCartAutomatic = false,
    this.supplierEmail = "",
    this.productCode = 0,
  });
  addNewProductToCart(int num) {
    addedToCart += num;
  }

  adjustProductQuantity(int num) {
    quantity += num;
  }

  int getTotalPrice() {
    return sellingPrice * addedToCart;
  }

  bool isZeroWarning() {
    if (addedToCart <= 0) {
      return true;
    }
    return false;
  }

  bool isMaxProductWarning() {
    if (addedToCart >= quantity) {
      return true;
    }
    return false;
  }

  bool compareToCart(int val) {
    if (val >= (quantity - addedToCart)) {
      return true;
    }
    return false;
  }

  int availableQuantity() {
    return quantity - addedToCart;
  }

  bool isStockLevelReached() {
    if (quantity <= stockLevel) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shopId': shopId,
      'isService': boolToInt(isService),
      'productUnit': productUnit,
      'productName': productName,
      'quantity': quantity,
      'purchasesPrice': purchasesPrice,
      'sellingPrice': sellingPrice,
      'stockLevel': stockLevel,
      'supplierName': supplierName,
      'supplierContact': supplierContact,
      'thumbnail': thumbnail,
    };
  }
}

SingleProduct fromJsonProduct(Map<String, dynamic> dx) {
  return SingleProduct(
    shopId: dx['shopId'],
    isService: intTobool(dx['isService']),
    productUnit: dx["productUnit"],
    id: dx['id'],
    productName: dx["productName"],
    quantity: dx['quantity'],
    purchasesPrice: dx['purchasesPrice'],
    sellingPrice: dx['sellingPrice'],
    stockLevel: dx['stockLevel'],
    supplierName: dx['supplierName'],
    supplierContact: "${dx['supplierContact']}",
    thumbnail: dx['thumbnail'],
  );
}

class CustomersGeneral {
  int totalDebtWeek;
  int customersDebtWeek;
  int totalDebtMonth;
  int customersDebtMonth;

  CustomersGeneral({
    required this.totalDebtWeek,
    required this.customersDebtWeek,
    required this.totalDebtMonth,
    required this.customersDebtMonth,
  });
}
