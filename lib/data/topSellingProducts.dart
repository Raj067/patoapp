class InventAnalysisData {
  String instock;
  String inventoryTurnover;
  String stockin;
  String stockout;

  InventAnalysisData({
    required this.instock,
    required this.inventoryTurnover,
    required this.stockin,
    required this.stockout,
  });
}

InventAnalysisData InventoryAnalysisData = InventAnalysisData(
    instock: "2,000", stockout: "821", stockin: "751", inventoryTurnover: "9");

class SingleTopProduct {
  String productName;
  String thumbnail;
  String quantity;
  bool isOutStock;
  String margin;
  String totalItemsSold;
  String id;

  SingleTopProduct({
    this.productName = "",
    this.thumbnail =
        "https://cdn.pixabay.com/photo/2016/03/18/01/09/cupcake-1264214_960_720.png",
    this.quantity = "0",
    this.isOutStock = true,
    this.totalItemsSold = "90",
    this.margin = "80%",
    this.id = '1',
  });
}

topSellingItemsDetails() {
  return [
    SingleTopProduct(
      productName: "Product 1",
      thumbnail:
          "https://cdn.pixabay.com/photo/2014/11/05/15/57/salmon-518032_960_720.jpg",
      isOutStock: false,
      id: '1',
    ),
    SingleTopProduct(
      productName: "Product 2",
      // thumbnail: "",
      isOutStock: true,
      id: '2',
    ),
    SingleTopProduct(
      productName: "Product 3",
      // thumbnail: "",
      quantity: "67",
      isOutStock: false,
      id: '3',
    ),
    SingleTopProduct(
      productName: "Product 4",
      // thumbnail: "",
      quantity: "78",
      isOutStock: false,
      id: '4',
    ),
  ];
}
