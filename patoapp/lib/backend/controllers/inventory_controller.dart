import 'package:get/get.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_Inventory.dart';
import 'package:patoapp/backend/models/inventory_tracking.dart';

class InventoryController extends GetxController {
  RxList<InventoryTracking> allData = <InventoryTracking>[].obs;

  Future<int> addInventory(InventoryTracking inventory) async {
    return await DBHelperInventory.insertDb(inventory);
  }

  Future<int> updateInventory(InventoryTracking inventory) async {
    return await DBHelperInventory.updateItem(inventory);
  }

  Future<void> deleteInventory(InventoryTracking inventory) async {
    await DBHelperInventory.deleteItem(inventory);
  }

  fetchInventoryDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> business = await DBHelperInventory.query();
    List<InventoryTracking> finalData = [];

    for (Map<String, dynamic> dx in business) {
      if (dx['shopId'] == shopId) {
        finalData.add(fromJsonInventoryTrack(dx));
      }
    }

    allData.value = finalData;
  }
}
