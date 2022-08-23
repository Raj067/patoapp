import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_customer.dart';
import 'package:patoapp/backend/models/customer_list.dart';

class CustomerController extends GetxController {
  var toBePaid = 0.obs;
  var toBeReceived = 0.obs;
  RxList<SingleCustomer> allCustomers = <SingleCustomer>[].obs;

  @override
  void onInit() {
    if (allCustomers.isEmpty) {
      fetchCustomersDB();
    }
    super.onInit();
  }

  Future<int> addCustomer(SingleCustomer customer) async {
    return await DBHelperCustomer.insertDb(customer);
  }

  Future<int> updateCustomer(SingleCustomer customer) async {
    return await DBHelperCustomer.updateItem(customer);
  }

  Future<void> deleteCustomer(SingleCustomer customer) async {
    await DBHelperCustomer.deleteItem(customer);
  }

  fetchCustomersDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> customers = await DBHelperCustomer.query();
    List<SingleCustomer> finalData = [];
    toBePaid.value = 0;
    toBeReceived.value = 0;
    for (Map<String, dynamic> e in customers) {
      if (e['shopId'] == shopId) {
        if (fromJsonCustomer(e).isToReceive()) {
          toBePaid.value += fromJsonCustomer(e).amount;
        } else {
          toBeReceived.value += fromJsonCustomer(e).amount * -1;
        }
        finalData.add(fromJsonCustomer(e));
      }
    }
    allCustomers.value = finalData;
  }

  customerChangeUpdater(SingleCustomer customer) {
    // after successfully updated
    // 1. Update state
    SingleCustomer oldCustomer =
        allCustomers.firstWhere((element) => element.id == customer.id);
    int index = allCustomers.indexOf(oldCustomer);
    allCustomers.remove(oldCustomer);
    allCustomers.insert(index, customer);

    update();
    // 2. Send data to local DB
    updateCustomer(customer);
  }

  customerChangeAdd(SingleCustomer customer) {
    // after successfully updated

    // 1. Update state
    allCustomers.insert(0, customer);
    update();

    // 2. Send data to local DB, so as to update it
    addCustomer(customer);
  }
}
