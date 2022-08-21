import 'package:patoapp/backend/sync/sync_business.dart';
import 'package:patoapp/backend/sync/sync_customers.dart';
import 'package:patoapp/backend/sync/sync_invoice.dart';
import 'package:patoapp/backend/sync/sync_products.dart';

// To be put after every transction that affect other aspect
syncAllImportantData() async {
  // Sync Customer
  SyncCustomers syncCustomer = SyncCustomers();
  syncCustomer.fetchData();
  // Sync Transactions
  SyncBusiness syncBusiness = SyncBusiness();
  syncBusiness.fetchData();
  // Sync All Product
  SyncProduct syncProduct = SyncProduct();
  syncProduct.fetchData();
  // Sync invoice
  SyncInvoice syncInvoice = SyncInvoice();
  syncInvoice.fetchData();
}

syncAllImportantContactOnly() async {
  // Sync Customer
  SyncCustomers syncCustomer = SyncCustomers();
  syncCustomer.fetchData();
}

syncAllImportantForPartiesPageOnly() async {
  // Sync Transactions
  SyncBusiness syncBusiness = SyncBusiness();
  syncBusiness.fetchData();
}

syncAllImportantForBusinessTransactions() async {
  // Sync Transactions
  SyncBusiness syncBusiness = SyncBusiness();
  syncBusiness.fetchData();
  // Sync All Product
  SyncProduct syncProduct = SyncProduct();
  syncProduct.fetchData();
  // Sync Customer
  SyncCustomers syncCustomer = SyncCustomers();
  syncCustomer.fetchData();
}

syncAllImportantProductTransaction() async {
  // Sync All Product
  SyncProduct syncProduct = SyncProduct();
  syncProduct.fetchData();
  // Sync Transactions
  SyncBusiness syncBusiness = SyncBusiness();
  syncBusiness.fetchData();
}

syncAllImportantProductOnly() async {
  // Sync All Product
  SyncProduct syncProduct = SyncProduct();
  syncProduct.fetchData();
}

syncAllImportantTransactionOnly() async {
  // Sync All Product
  SyncProduct syncProduct = SyncProduct();
  syncProduct.fetchData();
}
