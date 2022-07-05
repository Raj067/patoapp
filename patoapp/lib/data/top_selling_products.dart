class InventAnalysisData {
  int instock;
  int inventoryTurnover;
  int stockin;
  int stockout;

  InventAnalysisData({
    required this.instock,
    required this.inventoryTurnover,
    required this.stockin,
    required this.stockout,
  });
}

class SingleTopProduct {
  String productName;
  String thumbnail;
  int quantity;
  bool isOutStock;
  String margin;
  String unit;
  int totalItemsSold;

  SingleTopProduct({
    required this.productName,
    required this.thumbnail,
    required this.quantity,
    required this.isOutStock,
    required this.totalItemsSold,
    required this.margin,
    required this.unit,
  });
}
