
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
}
