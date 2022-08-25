import 'package:get/get.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_business.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';

class BusinessController extends GetxController {
  RxList<FinancialData> allFinancialData = <FinancialData>[].obs;

  @override
  void onInit() {
    if (allFinancialData.isEmpty) {
      fetchBusinessDB();
    }
    super.onInit();
  }

  Future<int> addBusiness(FinancialData business) async {
    return await DBHelperBusiness.insertDb(business);
  }

  Future<int> updateBusiness(FinancialData business) async {
    return await DBHelperBusiness.updateItem(business);
  }

  Future<void> deleteBusiness(FinancialData business) async {
    await DBHelperBusiness.deleteItem(business);
  }

  fetchBusinessDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> business = await DBHelperBusiness.query();
    List<FinancialData> finalData = [];

    for (Map<String, dynamic> dx in business) {
      if (dx['shopId'] == shopId) {
        finalData.add(fromJsonBusiness(dx));
      }
    }
    finalData.sort((b, a) => a.date.compareTo(b.date));
    allFinancialData.value = finalData;
  }

  businessChangeAdd(FinancialData business) {
    // after successfully updated

    // 1. Update state
    allFinancialData.insert(0, business);
    update();

    // 2. Send data to local DB, so as to update it
    addBusiness(business);
  }

  businessChangeDelete(FinancialData business) {
    // after successfully updated
    // 1. Update state
    allFinancialData.remove(business);
    update();
    // 2. Send data to local DB
    deleteBusiness(business);
  }
}
