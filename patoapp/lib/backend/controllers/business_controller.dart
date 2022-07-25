import 'package:get/get.dart';
import 'package:patoapp/backend/db/db_business.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';

class BusinessController extends GetxController {
  Future<int> addBusiness(FinancialData business) async {
    return await DBHelperBusiness.insertDb(business);
  }

  Future<int> updateBusiness(FinancialData business) async {
    return await DBHelperBusiness.updateItem(business);
  }

  Future<void> deleteBusiness(FinancialData business) async {
    await DBHelperBusiness.deleteItem(business);
  }

  // // get all shedule in the database
  // Future<List<FinancialData>> getBusinesss() async {
  //   List<Map<String, dynamic>> business = await DBHelperBusiness.query();
  //   return business
  //       .map((e) => FinancialData(
  //             id: e['id'],
  //             amount: e['amount'],
  //             fullName: e['fullName'],
  //             address: e['address'],
  //             phoneNumber: e['phoneNumber'],
  //             email: e['email'],
  //             financialData: jsonDecode(e['financialData']),
  //           ))
  //       .toList();
  // }
}
