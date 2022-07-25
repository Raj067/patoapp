import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/business_controller.dart';
import 'package:patoapp/backend/db/db_business.dart';
import 'package:patoapp/backend/funcs/misc.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';

class SyncBusiness {
  final BusinessController _businessController = Get.put(BusinessController());
  fetchData() async {
    String accessToken = await storage.read(key: 'access') ?? "";

    var data = await http.get(
      Uri.parse(
        "${baseUrl}api/business-financial-transactions/",
      ),
      headers: getAuthHeaders(accessToken),
    );
    if (data.statusCode == 200) {
      for (var dx in jsonDecode(data.body)) {
        FinancialData myData = FinancialData(
          date: DateTime.parse(dx['date']),
          isCashSale: dx['isCashSale'],
          isPaymentIn: dx['isPaymentIn'],
          isExpenses: dx['isExpenses'],
          isPaymentOut: dx['isPaymentOut'],
          isPurchases: dx['isPurchases'],
          isInvoice: dx['isInvoice'],
          name: dx['name'] ?? "",
          description: dx['description'] ?? "",
          details: dx['details'],
          amount: dx['amount'],
          receipt: dx['receipt'],
          discount: dx['discount'],
          id: dx['id'],
        );
        // Add data to the database
        try {
          await _businessController.addBusiness(myData);
        } catch (e) {
          // else update existing data
          await _businessController.updateBusiness(myData);
        }
      }
      // Check if data is present in the
      // server database but not in the local database
      //  == Deleting the data that is no longer stored in the database.
      List<Map<String, dynamic>> business = await DBHelperBusiness.query();
      List<FinancialData> localDb = [];
      localDb.addAll(business
          .map((dx) => FinancialData(
                date: DateTime.parse(dx['date']),
                isCashSale: intTobool(dx['isCashSale']),
                isPaymentIn: intTobool(dx['isPaymentIn']),
                isExpenses: intTobool(dx['isExpenses']),
                isPaymentOut: intTobool(dx['isPaymentOut']),
                isPurchases: intTobool(dx['isPurchases']),
                isInvoice: intTobool(dx['isInvoice']),
                name: dx['name'] ?? "",
                description: dx['description'] ?? "",
                details: jsonDecode(dx['details']),
                amount: dx['amount'],
                receipt: "${dx['receipt']}",
                discount: dx['discount'],
                id: dx['id'],
              ))
          .toList());
      List<dynamic> serverDb =
          jsonDecode(data.body).map((e) => e['id']).toList();
      for (FinancialData dx in localDb) {
        if (!serverDb.contains(dx.id)) {
          // If data present in the local database
          //but not on the server delete it
          await _businessController.deleteBusiness(dx);
        }
      }
    }
  }
}
