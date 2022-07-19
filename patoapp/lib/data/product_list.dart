// Note: only post changes to the backend where necessary, otherwise not sending them,
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
  String productUnit = '';
  bool isService=false;

  SingleProduct({
    required this.productName,
    required this.sellingPrice,
    required this.purchasesPrice,
    required this.id,
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

  void makeSales() {
    // make sales and changes the sales actions to the backend
  }
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

// List<SingleProduct> allProductDetails() {
//   return [
//     SingleProduct(
//       purchasesPrice: 1500,
//       sellingPrice: 2500,
//       productName: "Colgate",
//       // thumbnail: "",
//       quantity: 20,
//       stockLevel: 20,
//       id: '1',
//     ),
//     SingleProduct(
//       purchasesPrice: 450,
//       sellingPrice: 700,
//       productName: "Jamaa",
//       // thumbnail: "",
//       quantity: 20,

//       id: '2',
//     ),
//     SingleProduct(
//       purchasesPrice: 1800,
//       sellingPrice: 3000,
//       productName: "Nido",
//       // thumbnail: "",
//       quantity: 20,

//       id: '3',
//     ),
//     SingleProduct(
//       purchasesPrice: 950,
//       sellingPrice: 1200,
//       productName: "Sembe",
//       // thumbnail: "",
//       quantity: 20,

//       id: '4',
//     ),
//     SingleProduct(
//       purchasesPrice: 2000,
//       sellingPrice: 2500,
//       productName: "Omo",
//       // thumbnail: "",
//       quantity: 20,

//       id: '5',
//     ),
//     SingleProduct(
//       purchasesPrice: 750,
//       sellingPrice: 1000,
//       productName: "Doffi",
//       // thumbnail: "",
//       quantity: 20,

//       id: '6',
//     ),
//   ];
// }
