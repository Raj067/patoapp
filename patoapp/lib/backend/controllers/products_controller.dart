import 'package:get/get.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_products.dart';
import 'package:patoapp/backend/models/product_list.dart';

class ProductController extends GetxController {
  RxList<SingleProduct> allProducts = <SingleProduct>[].obs;
  RxInt addedItemsToCart = 0.obs;
  RxInt allAddedProduct = 0.obs;
  RxInt allAddedProductPrice = 0.obs;

  @override
  void onInit() {
    if (allProducts.isEmpty) {
      fetchProductsDB();
    }
    super.onInit();
  }

  fetchProductsDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> products = await DBHelperProduct.query();
    List<SingleProduct> finalData = [];
    for (Map<String, dynamic> e in products) {
      if (e['shopId'] == shopId) {
        finalData.add(fromJsonProduct(e));
      }
    }
    allProducts.value = finalData;
  }

  Future<int> addProduct(SingleProduct product) async {
    return await DBHelperProduct.insertDb(product);
  }

  Future<int> updateProduct(SingleProduct product) async {
    return await DBHelperProduct.updateItem(product);
  }

  Future<void> deleteProduct(SingleProduct product) async {
    await DBHelperProduct.deleteItem(product);
  }

  productChangeUpdater(SingleProduct product) {
    // after successfully updated
    // 1. Update state
    SingleProduct oldProduct =
        allProducts.firstWhere((element) => element.id == product.id);
    int index = allProducts.indexOf(oldProduct);
    allProducts.remove(oldProduct);
    allProducts.insert(index, product);

    update();
    // 2. Send data to local DB
    updateProduct(product);
  }

  productChangeDelete(SingleProduct product) {
    // after successfully updated
    // 1. Update state
    allProducts.remove(product);
    update();
    // 2. Send data to local DB
    deleteProduct(product);
  }

  productChangeAdd(SingleProduct customer) {
    // after successfully updated

    // 1. Update state
    allProducts.insert(0, customer);
    update();

    // 2. Send data to local DB, so as to update it
    addProduct(customer);
  }
}
