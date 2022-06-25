// Note: only post changes to the backend where necessary, otherwise not sending them,
class SingleProduct {
  String productName;
  String thumbnail;
  int quantity;
  bool isOutStock;
  int sellingPrice;
  int purchasesPrice;
  String supplierName;
  String supplierContact;
  int totalItemsSold;
  int addedToCart = 0;
  bool isAddedToCartAutomatic = false;
  String id;

  SingleProduct({
    required this.productName,
    required this.sellingPrice,
    required this.purchasesPrice,
    required this.id,
    required this.quantity,
    this.thumbnail = "",
    this.isOutStock = true,
    this.totalItemsSold = 90,
    this.supplierName = "Rajabu",
    this.supplierContact = "+255679190720",
    this.addedToCart = 0,
    this.isAddedToCartAutomatic = false,
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

  void makeSales() {
    // make sales and changes the sales actions to the backend
  }
}

List<SingleProduct> allProductDetails() {
  return [
    SingleProduct(
      purchasesPrice: 1200,
      sellingPrice: 4090,
      productName: "Product 6",
      // thumbnail: "",
      quantity: 55,
      isOutStock: false,
      id: '6',
    ),
    SingleProduct(
      purchasesPrice: 1900,
      sellingPrice: 4090,
      productName: "Product 7",
      // thumbnail: "",
      quantity: 86,
      isOutStock: true,
      id: '7',
    ),
  ];
}
