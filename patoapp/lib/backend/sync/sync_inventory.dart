import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/inventory_controller.dart';
import 'package:patoapp/backend/db/db_customer.dart';
import 'package:patoapp/backend/models/inventory_tracking.dart';

class SyncInventory {
  final InventoryController _inventoryController =
      Get.put(InventoryController());
  fetchData() async {
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      // Financial data
      var data = await http.get(
        Uri.parse("${baseUrl}api/inventory-track/"),
        headers: getAuthHeaders(accessToken),
      );
      if (data.statusCode == 200) {
        for (var dx in jsonDecode(data.body)) {
          InventoryTracking myData = InventoryTracking(
            quantityAdded: dx['quantity_added'],
            purchasesPrice: dx['purchases_price'],
            createdAt: dx['created_at'],
            updatedAt: dx['updated_at'],
            id: dx['id'],
            shopId: dx['shopId'],
          );
          // Add data to the database
          try {
            await _inventoryController.addInventory(myData);
          } catch (e) {
            // else update existing data
            await _inventoryController.updateInventory(myData);
          }
        } // Check if data is present in the
        // server database but not in the local database
        //  == Deleting the data that is no longer stored in the database.
        List<Map<String, dynamic>> customers = await DBHelperCustomer.query();
        List<InventoryTracking> localDb = [];
        localDb
            .addAll(customers.map((e) => fromJsonInventoryTrack(e)).toList());
        List<dynamic> serverDb =
            jsonDecode(data.body).map((e) => e['id']).toList();

        for (InventoryTracking dx in localDb) {
          if (!serverDb.contains(dx.id)) {
            // If data present in the local database
            //but not on the server delete it deleteCustomer
            await _inventoryController.deleteInventory(dx);
          }
        }
      }
    } catch (e) {
      // Thereis no internent
    }
  }
}
