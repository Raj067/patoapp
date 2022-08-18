import 'package:get/get.dart';
import 'package:patoapp/backend/db/db_Inventory.dart';
import 'package:patoapp/backend/models/inventory_tracking.dart';

class InventoryController extends GetxController {
  Future<int> addInventory(InventoryTracking inventory) async {
    return await DBHelperInventory.insertDb(inventory);
  }

  Future<int> updateInventory(InventoryTracking inventory) async {
    return await DBHelperInventory.updateItem(inventory);
  }

  Future<void> deleteInventory(InventoryTracking inventory) async {
    await DBHelperInventory.deleteItem(inventory);
  }
}
