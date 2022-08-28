import 'package:get/get.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_invoices.dart';
import 'package:patoapp/backend/models/invoice_model.dart';

class InvoiceController extends GetxController {
  RxList<SingleInvoice> allInvoice = <SingleInvoice>[].obs;
  var totalUnpaidInvoice = 0.obs;
  var totalOutstanding = 0.obs;
  var totalOverdue = 0.obs;

  @override
  void onInit() {
    if (allInvoice.isEmpty) {
      fetchInvoiceDB();
    }
    super.onInit();
  }

  Future<int> addInvoice(SingleInvoice invoice) async {
    return await DBHelperInvoice.insertDb(invoice);
  }

  Future<int> updateInvoice(SingleInvoice invoice) async {
    return await DBHelperInvoice.updateItem(invoice);
  }

  Future<void> deleteInvoice(SingleInvoice invoice) async {
    await DBHelperInvoice.deleteItem(invoice);
  }

  fetchInvoiceDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> invoice = await DBHelperInvoice.query();
    List<SingleInvoice> finalData = [];
    for (Map<String, dynamic> e in invoice) {
      if (e['shopId'] == shopId) {
        finalData.add(fromJsonInvoice(e));
      }
    }
    allInvoice.value = finalData;
  }

  invoiceChangeUpdater(SingleInvoice invoice) {
    // after successfully updated
    // 1. Update state
    SingleInvoice oldInvoice =
        allInvoice.firstWhere((element) => element.id == invoice.id);
    int index = allInvoice.indexOf(oldInvoice);
    allInvoice.remove(oldInvoice);
    allInvoice.insert(index, invoice);

    update();
    // 2. Send data to local DB
    updateInvoice(invoice);
  }

  invoiceChangeAdd(SingleInvoice invoice) {
    // after successfully updated

    // 1. Update state
    allInvoice.insert(0, invoice);
    update();

    // 2. Send data to local DB, so as to update it
    addInvoice(invoice);
  }

  invoiceChangeDelete(SingleInvoice invoice) {
    // after successfully updated
    // 1. Update state
    allInvoice.remove(invoice);
    update();
    // 2. Send data to local DB
    deleteInvoice(invoice);
  }
}
