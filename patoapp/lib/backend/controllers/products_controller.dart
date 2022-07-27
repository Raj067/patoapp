import 'package:get/get.dart';
import 'package:patoapp/backend/db/db_products.dart';
import 'package:patoapp/backend/models/product_list.dart';

class ProductController extends GetxController {
  Future<int> addProduct(SingleProduct product) async {
    return await DBHelperProduct.insertDb(product);
  }

  Future<int> updateProduct(SingleProduct product) async {
    return await DBHelperProduct.updateItem(product);
  }

  Future<void> deleteProduct(SingleProduct product) async {
    await DBHelperProduct.deleteItem(product);
  }
}
