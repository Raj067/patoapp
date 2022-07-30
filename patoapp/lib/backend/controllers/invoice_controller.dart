import 'package:get/get.dart';
import 'package:patoapp/backend/db/db_invoices.dart';
import 'package:patoapp/backend/models/invoice_model.dart';

class InvoiceController extends GetxController {
  Future<int> addInvoice(SingleInvoice invoice) async {
    return await DBHelperInvoice.insertDb(invoice);
  }

  Future<int> updateInvoice(SingleInvoice invoice) async {
    return await DBHelperInvoice.updateItem(invoice);
  }

  Future<void> deleteInvoice(SingleInvoice invoice) async {
    await DBHelperInvoice.deleteItem(invoice);
  }
}
