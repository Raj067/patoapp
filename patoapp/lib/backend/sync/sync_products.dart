import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/products_controller.dart';
import 'package:patoapp/backend/db/db_products.dart';
import 'package:patoapp/backend/models/product_list.dart';

class SyncProduct {
  final ProductController _productController = Get.put(ProductController());
  fetchData() async {
    String accessToken = await storage.read(key: 'access') ?? "";

    // Financial data
    var data = await http.get(
      Uri.parse("${baseUrl}api/inventory-products/"),
      headers: getAuthHeaders(accessToken),
    );
    if (data.statusCode == 200) {
      for (var dx in jsonDecode(data.body)) {
        SingleProduct myData = SingleProduct(
          shopId: dx["shopId"],
          isService: dx['is_service'] ?? false,
          productUnit: dx["primary_unit"] ?? "Items",
          id: dx['id'],
          productName: dx["product_name"],
          quantity: dx['quantity'],
          purchasesPrice: dx['purchases_price'],
          sellingPrice: dx['selling_price_primary'],
          stockLevel: dx['stock_level'] ?? 0,
          supplierName: dx['supplier_name'] ?? '',
          supplierContact: dx['supplier_number'] ?? '',
          thumbnail: dx['product_image'] ?? '',
        );
        // Add data to the database
        try {
          await _productController.addProduct(myData);
        } catch (e) {
          // else update existing data
          await _productController.updateProduct(myData);
        }
      } // Check if data is present in the
      // server database but not in the local database
      //  == Deleting the data that is no longer stored in the database.
      List<Map<String, dynamic>> product = await DBHelperProduct.query();
      List<SingleProduct> localDb = [];
      localDb.addAll(product.map((e) => fromJsonProduct(e)).toList());
      List<dynamic> serverDb =
          jsonDecode(data.body).map((e) => e['id']).toList();

      for (SingleProduct dx in localDb) {
        if (!serverDb.contains(dx.id)) {
          // If data present in the local database
          //but not on the server delete it deleteCustomer
          await _productController.deleteProduct(dx);
        }
      }
    }
  }
}
