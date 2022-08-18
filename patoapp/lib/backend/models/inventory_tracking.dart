class InventoryTracking {
  int id;
  int shopId;
  int quantityAdded;
  int purchasesPrice;
  String createdAt;
  String updatedAt;
  InventoryTracking({
    required this.id,
    required this.shopId,
    required this.quantityAdded,
    required this.purchasesPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shopId': shopId,
      'quantityAdded': quantityAdded,
      'purchasesPrice': purchasesPrice,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

InventoryTracking fromJsonInventoryTrack(Map<String, dynamic> e) {
  return InventoryTracking(
    id: e['id'],
    shopId: e['shopId'],
    quantityAdded: e['quantityAdded'],
    purchasesPrice: e['purchasesPrice'],
    createdAt: e['createdAt'],
    updatedAt: e['updatedAt'],
  );
}
