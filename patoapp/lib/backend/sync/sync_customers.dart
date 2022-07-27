import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/customers_controller.dart';
import 'package:patoapp/backend/db/db_customer.dart';
import 'package:patoapp/backend/models/customer_list.dart';

class SyncCustomers {
  final CustomerController _customerController = Get.put(CustomerController());
  fetchData() async {
    String accessToken = await storage.read(key: 'access') ?? "";

    // Financial data
    var data = await http.get(
      Uri.parse("${baseUrl}api/parties-details/"),
      headers: getAuthHeaders(accessToken),
    );
    if (data.statusCode == 200) {
      for (var dx in jsonDecode(data.body)) {
        SingleCustomer myData = SingleCustomer(
          address: dx['customer_address'] ?? "",
          email: dx['customer_email'] ?? "",
          financialData: dx['financial_data'],
          fullName: dx['customer_name'],
          phoneNumber: "${dx['customer_number']}",
          amount: dx['effective_amount'],
          id: dx['id'],
          shopId: dx['shopId'],
        );
        // Add data to the database
        try {
          await _customerController.addCustomer(myData);
        } catch (e) {
          // else update existing data
          await _customerController.updateCustomer(myData);
        }
      } // Check if data is present in the
      // server database but not in the local database
      //  == Deleting the data that is no longer stored in the database.
      List<Map<String, dynamic>> customers = await DBHelperCustomer.query();
      List<SingleCustomer> localDb = [];
      localDb.addAll(customers.map((e) => fromJsonCustomer(e)).toList());
      List<dynamic> serverDb =
          jsonDecode(data.body).map((e) => e['id']).toList();

      for (SingleCustomer dx in localDb) {
        if (!serverDb.contains(dx.id)) {
          // If data present in the local database
          //but not on the server delete it deleteCustomer
          await _customerController.deleteCustomer(dx);
        }
      }
    }
  }
}
