import 'package:patoapp/backend/sync/sync_business.dart';
import 'package:patoapp/backend/sync/sync_customers.dart';
import 'package:patoapp/backend/sync/sync_invoice.dart';
import 'package:patoapp/backend/sync/sync_products.dart';

// To be put after every transction that affect other aspect
syncAllImportantData() async {
  // Sync Transactions
  SyncBusiness syncBusiness = SyncBusiness();
  syncBusiness.fetchData();
  // Sync All Product
  SyncProduct syncProduct = SyncProduct();
  syncProduct.fetchData();
  // Sync Customer
  SyncCustomers syncCustomer = SyncCustomers();
  syncCustomer.fetchData();
  // Sync invoice
  SyncInvoice syncInvoice = SyncInvoice();
  syncInvoice.fetchData();
}
