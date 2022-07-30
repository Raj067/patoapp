import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/invoice_controller.dart';
import 'package:patoapp/backend/db/db_invoices.dart';
import 'package:patoapp/backend/models/invoice_model.dart';

class SyncInvoice {
  final InvoiceController _invoiceController = Get.put(InvoiceController());
  fetchData() async {
    String accessToken = await storage.read(key: 'access') ?? "";

    // Financial data
    var data = await http.get(
      Uri.parse("${baseUrl}api/all-invoices/"),
      headers: getAuthHeaders(accessToken),
    );
    if (data.statusCode == 200) {
      for (var e in jsonDecode(data.body)) {
        SingleInvoice myData = SingleInvoice(
          id: e['id'],
          shopId: e['shopId'],
          customerId: e['customer_data'],
          fullName: e['fullName'],
          amountReceived: e['amount_received'],
          discount: e['discount'],
          dueDate: e['due_date'],
          items: e['items'],
          invoiceNo: e['invoice_no'],
          description: e['description'],
        );

        // Add data to the database
        try {
          await _invoiceController.addInvoice(myData);
        } catch (e) {
          // else update existing data
          await _invoiceController.updateInvoice(myData);
        }
      } // Check if data is present in the
      // server database but not in the local database
      //  == Deleting the data that is no longer stored in the database.
      List<Map<String, dynamic>> invoice = await DBHelperInvoice.query();
      List<SingleInvoice> localDb = [];
      localDb.addAll(invoice.map((e) => fromJsonInvoice(e)).toList());
      List<dynamic> serverDb =
          jsonDecode(data.body).map((e) => e['id']).toList();

      for (SingleInvoice dx in localDb) {
        if (!serverDb.contains(dx.id)) {
          // If data present in the local database
          //but not on the server delete it deleteCustomer
          await _invoiceController.deleteInvoice(dx);
        }
      }
    }
  }
}
