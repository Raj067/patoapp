import 'dart:convert';

import 'package:get/get.dart';
import 'package:patoapp/backend/db/db_customer.dart';
import 'package:patoapp/backend/models/customer_list.dart';

class CustomerController extends GetxController {
  Future<int> addCustomer(SingleCustomer customer) async {
    return await DBHelperCustomer.insertDb(customer);
  }

  Future<int> updateCustomer(SingleCustomer customer) async {
    return await DBHelperCustomer.updateItem(customer);
  }

  Future<void> deleteCustomer(SingleCustomer customer) async {
    await DBHelperCustomer.deleteItem(customer);
  }

  // get all shedule in the database
  Future<List<SingleCustomer>> getCustomers() async {
    List<Map<String, dynamic>> customer = await DBHelperCustomer.query();
    return customer
        .map((e) => SingleCustomer(
              id: e['id'],
              amount: e['amount'],
              fullName: e['fullName'],
              address: e['address'],
              phoneNumber: e['phoneNumber'],
              email: e['email'],
              financialData: jsonDecode(e['financialData']),
            ))
        .toList();
  }
}
