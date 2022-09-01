import 'dart:convert';
import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/business_controller.dart';
import 'package:patoapp/backend/controllers/customers_controller.dart';
import 'package:patoapp/backend/controllers/products_controller.dart';
// import 'package:patoapp/backend/db/db_customer.dart';
// import 'package:patoapp/backend/db/db_products.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
// import 'package:patoapp/backend/sync/sync_all.dart';
// import 'package:patoapp/backend/sync/sync_business.dart';
// import 'package:patoapp/backend/sync/sync_customers.dart';
import 'package:patoapp/business/add_items/to_purchases.dart';
import 'package:patoapp/business/add_items/to_sales.dart';
import 'package:patoapp/business/add_new_customer.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/backend/models/product_list.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTransactionDialog extends StatefulWidget {
  // final Function resetData;
  // final List<SingleCustomer> finalData;
  const AddTransactionDialog({Key? key}) : super(key: key);

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  int _value = 1;
  final salesTransactionFormKey = GlobalKey<FormState>();
  final expensesTransactionFormKey = GlobalKey<FormState>();
  final CustomerController _customerController = Get.put(CustomerController());
  final ProductController _productController = Get.put(ProductController());

  List<SingleProduct> addedItemsToSales = [];
  List<SingleProduct> addedItemsToPurchases = [];

  int receiptNo = Random().nextInt(10000);
  int billNo = Random().nextInt(10000);
  DateTime transactionDate = DateTime.now();
  // for cash sales
  double totalAmount = 0;
  double discountAmount = 0;
  String? selectedValue;
  String? selectedCustmer;
  String expensesCategory = 'Other expenses';
  final TextEditingController customerController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController expensesController = TextEditingController();
// expenses
  final TextEditingController totalAmountPaid = TextEditingController();
  final TextEditingController expensesDescription = TextEditingController();
  final TextEditingController salesDescription = TextEditingController();
  double totalPurchasesAmount = 0.0;
  final BusinessController _businessController = Get.put(BusinessController());
  GlobalKey dropdownkey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    customerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addTransaction,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patowaveWhite,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: _value == 1
                      ? patowaveGreen.withAlpha(100)
                      : Colors.grey.withAlpha(0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _value = 1;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          activeColor: patowaveGreen,
                          value: 1,
                          groupValue: _value,
                          onChanged: (val) {
                            setState(() {
                              _value = 1;
                            });
                          },
                        ),
                        Container(
                          width: 5,
                        ),
                        Text(AppLocalizations.of(context)!.cashSales),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: _value == 2
                      ? patowaveErrorRed.withAlpha(100)
                      : Colors.grey.withAlpha(0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _value = 2;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          activeColor: patowaveErrorRed,
                          value: 2,
                          groupValue: _value,
                          onChanged: (val) {
                            setState(() {
                              _value = 2;
                            });
                          },
                        ),
                        Container(
                          width: 5,
                        ),
                        Text(AppLocalizations.of(context)!.expenses),
                        Container(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Table(
            border: TableBorder.all(
              width: 1.0,
              color: Colors.grey.withAlpha(100),
            ),
            children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      _value == 1
                          ? "${AppLocalizations.of(context)!.receipt} No $receiptNo"
                          : "Bill No $billNo",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: transactionDate,
                        firstDate: DateTime(DateTime.now().year - 3),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(DateTime.now().year + 1),
                        initialDatePickerMode: DatePickerMode.day,
                        helpText: "Select Transaction  Date");

                    if (pickedDate != null) {
                      setState(() {
                        transactionDate = pickedDate;
                      });
                    } else {}
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "${AppLocalizations.of(context)!.date}: ${DateFormat("dd-MM-yyyy").format(transactionDate)}",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
          const Divider(height: 0),
          _value == 1 ? _addSales() : _addExpenses(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  // MaterialStateProperty<Color?>? backgroundColor,
                  minimumSize: MaterialStateProperty.all(
                    const Size(45, 45),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_value == 1) {
                    // for payment in

                    // Validate returns true if the form is valid, or false otherwise.
                    if (salesTransactionFormKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      _submitSalesCustomerData();
                    }
                  } else {
                    // for payment out

                    // Validate returns true if the form is valid, or false otherwise.
                    if (expensesTransactionFormKey.currentState!.validate()) {
                      addedItemsToPurchases.isNotEmpty
                          ? _submitPurchasesData()
                          : _submitExpensesData();
                    }
                  }
                },
                child: Text(AppLocalizations.of(context)!.save),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onAddingCustomer(SingleCustomer data) {
    selectedCustmer = "${data.id}";
    Navigator.pop(context);
  }

  _addSales() {
    return Expanded(
      child: Form(
        key: salesTransactionFormKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: [
            Container(height: 15),
            TextFormField(
              cursorColor: patowavePrimary,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.amountReceivedRequired;
                }
                if (value !=
                    "${totalAmount.toInt() - discountAmount.toInt()}") {
                  return "Amount received should be Tsh: ${totalAmount.toInt() - discountAmount.toInt()}";
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text(
                  "${AppLocalizations.of(context)!.amountReceived}*",
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 14),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            Container(height: 15),
            GetBuilder<CustomerController>(builder: (controller) {
              return DropdownButtonFormField2(
                  value: selectedCustmer,
                  selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  validator: (value) {
                    if (value == null || value == "") {
                      return AppLocalizations.of(context)!.selectCustomer;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(
                      '${AppLocalizations.of(context)!.selectCustomer}*',
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: _customerController.allCustomers
                      .map((item) => DropdownMenuItem<String>(
                            value: "${item.id}",
                            child: Text(
                              item.fullName,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                    setState(() {
                      selectedCustmer = value.toString();
                    });
                  },
                  onSaved: (value) {
                    selectedCustmer = value.toString();
                  },
                  searchController: customerController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: patowavePrimary,
                            controller: customerController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText:
                                  '${AppLocalizations.of(context)!.searchCustomer}...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    AddNewCustomerTransaction(
                                  refreshData: onAddingCustomer,
                                ),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: Text(AppLocalizations.of(context)!.add),
                        )
                      ],
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    String newVal = controller.allCustomers
                        .firstWhere(
                            (element) => element.id.toString() == item.value)
                        .fullName;
                    return (newVal
                        .toLowerCase()
                        .contains(searchValue.toLowerCase()));
                  },
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      customerController.clear();
                    }
                  });
            }),
            Container(height: 15),
            addedItemsToSales.isNotEmpty
                ? _allAddedItemsToSales(context)
                : Container(),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => AddItemsToSale(
                      allProducts: _productController.allProducts,
                      addedItemsToSales: addedItemsToSales,
                      addItems: _addItemsToSale,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: patowavePrimary.withAlpha(100),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.addItemsToSales,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _discount(),
            Container(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.discount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Tsh: ${discountAmount.toInt()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.totalAmount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Tsh: ${totalAmount.toInt() - discountAmount.toInt()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(height: 15),
            SizedBox(
              // height: 180,
              child: TextFormField(
                controller: salesDescription,
                cursorColor: patowavePrimary,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 3,
                maxLines: null,
                decoration: InputDecoration(
                  label: Text(
                    AppLocalizations.of(context)!.description,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addItemsToSale(SingleProduct dx) {
    addedItemsToSales.add(dx);
    setState(() {});
  }

  _addItemsToPurchases(SingleProduct dx) {
    addedItemsToPurchases.add(dx);
    setState(() {});
  }

  _addExpenses() {
    return Expanded(
      child: Form(
        key: expensesTransactionFormKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: [
            Container(height: 15),
            TextFormField(
              controller: totalAmountPaid,
              onChanged: (val) {
                setState(() {
                  totalAmountPaid.text;
                });
              },
              cursorColor: patowavePrimary,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.amountPaidRequired;
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text(
                  "${AppLocalizations.of(context)!.amountPaid}*",
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 14),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            Container(height: 15),
            Text(
              AppLocalizations.of(context)!.otherInformation,
              style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
            ),
            Container(height: 10),
            addedItemsToPurchases.isNotEmpty
                ? _allAddedItemsToPurchases(context)
                : Container(),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => AddItemsToPurchases(
                      allProducts: _productController.allProducts,
                      addedItemsToPurchases: addedItemsToPurchases,
                      addItems: _addItemsToPurchases,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: patowavePrimary.withAlpha(100),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.addItemsToPurchases,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(height: 15),
            addedItemsToPurchases.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                      color: patowaveBlack.withAlpha(30),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                      child: Text(
                        AppLocalizations.of(context)!.purchases,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                : DropdownButtonFormField2(
                    selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                    scrollbarAlwaysShow: true,
                    dropdownMaxHeight: 200,
                    decoration: InputDecoration(
                      label: Text(
                        AppLocalizations.of(context)!.expensesCategory,
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    isExpanded: true,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: expenses
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                      setState(() {
                        expensesCategory = value.toString();
                      });
                    },
                    onSaved: (value) {
                      expensesCategory = value.toString();
                    },
                    searchController: expensesController,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        cursorColor: patowavePrimary,
                        controller: expensesController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Search for expenses...',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().contains(searchValue));
                    },
                    //This to clear the search value when you close the menu
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        expensesController.clear();
                      }
                    },
                  ),
            Container(height: 15),
            GetBuilder<CustomerController>(
              builder: (controller) {
                return DropdownButtonFormField2(
                  value: selectedCustmer,
                  selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  validator: (val) {
                    if (addedItemsToPurchases.isNotEmpty &&
                        (val == null || val == '')) {
                      return AppLocalizations.of(context)!.pleaseSelectCustomer;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(
                      AppLocalizations.of(context)!.addContact,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: _customerController.allCustomers
                      .map((item) => DropdownMenuItem<String>(
                            value: "${item.id}",
                            child: Text(
                              item.fullName,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                    setState(() {
                      selectedCustmer = value.toString();
                    });
                  },
                  onSaved: (value) {
                    selectedCustmer = value.toString();
                  },
                  searchController: customerController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: patowavePrimary,
                            controller: customerController,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for contact...',
                              hintStyle: TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    AddNewCustomerTransaction(
                                  refreshData: onAddingCustomer,
                                ),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: Text(AppLocalizations.of(context)!.add),
                        )
                      ],
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    String newVal = _customerController.allCustomers
                        .firstWhere(
                            (element) => element.id.toString() == item.value)
                        .fullName;
                    return (newVal
                        .toLowerCase()
                        .contains(searchValue.toLowerCase()));
                  },
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      customerController.clear();
                    }
                  },
                );
              },
            ),
            Container(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.totalAmount,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tsh: ${totalAmountPaid.text}",
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            addedItemsToPurchases.isNotEmpty
                ? Column(
                    children: [
                      Container(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Balance due",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: patowaveErrorRed),
                          ),
                          Text(
                            "Tsh: ${int.parse(totalAmountPaid.text == '' ? '0' : totalAmountPaid.text) - totalPurchasesAmount}",
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: patowaveErrorRed),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
            Container(height: 15),
            TextFormField(
              controller: expensesDescription,
              cursorColor: patowavePrimary,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 3,
              maxLines: null,
              decoration: InputDecoration(
                label: Text(
                  AppLocalizations.of(context)!.description,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 14),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _discount() {
    return Column(
      children: [
        Container(height: 15),
        const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 5, 15, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.discount),
              Container(width: 5),
              Container(
                width: 30,
                height: 35,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(52, 255, 70, 57),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.percent,
                    color: patowaveErrorRed,
                    size: 16,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextFormField(
                    cursorColor: patowavePrimary,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (val) {
                      // discountAmount
                      if (val != "") {
                        discountAmount = int.parse(val) / 100 * totalAmount;
                        setState(() {});
                      } else {
                        discountAmount = 0;
                        setState(() {});
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "0",
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          color: patowavePrimary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(width: 10),
              Container(
                width: 30,
                height: 35,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Tsh:",
                    style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextFormField(
                    cursorColor: patowavePrimary,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (val) {
                      if (val != "") {
                        discountAmount = double.parse(val);
                        setState(() {});
                      } else {
                        discountAmount = 0;
                        setState(() {});
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "0.00",
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          color: patowavePrimary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 0),
        Container(height: 15),
      ],
    );
  }

  _allAddedItemsToSales(BuildContext context) {
    List<Widget> data = [];
    double val = 0;
    for (SingleProduct dx in addedItemsToSales) {
      val += dx.quantity * dx.sellingPrice;
      data.add(_singleSelectedProduct(context, dx));
      data.add(Container(height: 10));
    }
    setState(() {
      totalAmount = val;
    });
    return Column(children: data);
  }

  _allAddedItemsToPurchases(BuildContext context) {
    List<Widget> data = [];
    double val = 0;
    for (SingleProduct dx in addedItemsToPurchases) {
      val += dx.quantity * dx.purchasesPrice;
      data.add(_singleSelectedProduct(context, dx, isSales: false));
      data.add(Container(height: 10));
    }
    setState(() {
      totalPurchasesAmount = val;
    });
    return Column(children: data);
  }

  _singleSelectedProduct(BuildContext context, SingleProduct product,
      {bool isSales = true}) {
    return Dismissible(
      key: Key("${product.id}"),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          _onDeleteData(context, product, isSales: isSales);
        } else {
          _onDeleteData(context, product, isSales: isSales);
        }
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.productName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    isSales
                        ? "Tsh ${product.quantity * product.sellingPrice}"
                        : "Tsh ${product.quantity * product.purchasesPrice}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Subtotal:",
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    isSales
                        ? "${product.quantity} ${product.productUnit} x Tsh ${product.sellingPrice} = Tsh ${product.quantity * product.sellingPrice}"
                        : "${product.quantity} ${product.productUnit} x Tsh ${product.purchasesPrice} = Tsh ${product.quantity * product.purchasesPrice}",
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onDeleteData(BuildContext context, SingleProduct product,
      {bool isSales = true}) {
    if (isSales) {
      List<SingleProduct> newData = [];
      double val = 0;
      for (SingleProduct dx in addedItemsToSales) {
        if (dx.id != product.id) {
          val += dx.quantity * dx.sellingPrice;
          newData.add(dx);
        }
      }
      setState(() {
        addedItemsToSales = newData;
        totalAmount = val;
      });
    } else {
      List<SingleProduct> newData = [];
      for (SingleProduct dx in addedItemsToPurchases) {
        if (dx.id != product.id) {
          newData.add(dx);
        }
      }
      setState(() {
        addedItemsToPurchases = newData;
      });
    }
    // allProducts
  }

  _submitPurchasesData() async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    List<Map> items = [];
    for (var element in addedItemsToPurchases) {
      items.add({
        "id": element.id,
        "price": element.sellingPrice,
        "quantity": element.quantity,
      });
    }
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/purchases-transaction/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'amount_paid':
              totalAmountPaid.text == '' ? 0 : int.parse(totalAmountPaid.text),
          'total_amount': totalPurchasesAmount,
          'items': items,
          'billNo': billNo,
          "shopId": shopId,
          'description': expensesDescription.text == ""
              ? "Purchases"
              : expensesDescription.text,
          "customer": selectedCustmer != null
              ? int.parse(selectedCustmer ?? '1')
              : null,
          "transactionDate": DateFormat("dd-MM-yyyy").format(transactionDate),
        }),
      );

      if (response.statusCode == 201) {
        FinancialData myData = FinancialData(
          date: DateTime.parse(jsonDecode(response.body)['date']),
          isCashSale: false,
          isPaymentIn: false,
          isExpenses: false,
          isPaymentOut: false,
          isPurchases: true,
          isInvoice: false,
          name: jsonDecode(response.body)['name'],
          description: jsonDecode(response.body)['description'],
          details: jsonDecode(response.body)['details'],
          amount: jsonDecode(response.body)['amount'].toInt(),
          receipt: "$receiptNo",
          discount: jsonDecode(response.body)['discount'].toInt(),
          id: jsonDecode(response.body)['id'],
          shopId: shopId,
        );
        _businessController.businessChangeAdd(myData);

        Get.back();

        Get.back();
        // Navigator
      } else {
        Get.back();
        showErrorMessage(
          context: context,
          builder: (context) => const ModalFitError(),
        );
        // throw Exception('Failed to updated customer.');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }

  _submitExpensesData() async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/expenses-transaction/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'amount_paid':
              totalAmountPaid.text == '' ? 0 : int.parse(totalAmountPaid.text),
          'category':
              expensesCategory == '' ? 'Other expenses' : expensesCategory,
          'description': expensesDescription.text == ""
              ? "Expenses"
              : expensesDescription.text,
          'billNo': billNo,
          "shopId": shopId,
          "customer": selectedCustmer != null
              ? int.parse(selectedCustmer ?? '1')
              : null,
          "transactionDate": DateFormat("dd-MM-yyyy").format(transactionDate),
        }),
      );

      if (response.statusCode == 201) {
        FinancialData myData = FinancialData(
          date: DateTime.parse(jsonDecode(response.body)['date']),
          isCashSale: false,
          isPaymentIn: false,
          isExpenses: true,
          isPaymentOut: false,
          isPurchases: false,
          isInvoice: false,
          name: jsonDecode(response.body)['name'],
          description: jsonDecode(response.body)['description'],
          details: jsonDecode(response.body)['details'],
          amount:
              totalAmountPaid.text == '' ? 0 : int.parse(totalAmountPaid.text),
          receipt: "$receiptNo",
          discount: discountAmount.toInt().toInt(),
          id: jsonDecode(response.body)['id'],
          shopId: shopId,
        );
        _businessController.businessChangeAdd(myData);

        Get.back();
        Get.back();
        // Navigator
      } else {
        Get.back();
        showErrorMessage(
          context: context,
          builder: (context) => const ModalFitError(),
        );
        // throw Exception('Failed to updated customer.');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }

  // api/cash-sales-customer-transaction/
  _submitSalesCustomerData() async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    List<Map> items = [];
    for (var element in addedItemsToSales) {
      items.add({
        "id": element.id,
        "price": element.sellingPrice,
        "quantity": element.quantity,
        "description": salesDescription.text,
      });
    }
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/cash-sales-customer-transaction/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'amount': totalAmount - discountAmount,
          'discount': discountAmount,
          'items': items,
          'receiptNo': receiptNo,
          'shopId': shopId,
          "customer": selectedCustmer != null
              ? int.parse(selectedCustmer ?? '1')
              : null,
          "transactionDate": DateFormat("dd-MM-yyyy").format(transactionDate),
        }),
      );

      if (response.statusCode == 201) {
        FinancialData myData = FinancialData(
          date: DateTime.parse(jsonDecode(response.body)['date']),
          isCashSale: true,
          isPaymentIn: false,
          isExpenses: false,
          isPaymentOut: false,
          isPurchases: false,
          isInvoice: false,
          name: jsonDecode(response.body)['name'],
          description: "Cash Sales",
          details: jsonDecode(response.body)['details'],
          amount: (totalAmount - discountAmount).toInt(),
          receipt: "$receiptNo",
          discount: discountAmount.toInt(),
          id: jsonDecode(response.body)['id'],
          shopId: shopId,
        );
        _businessController.businessChangeAdd(myData);

        Get.back();
        Get.back();
        // Navigator
      } else {
        Get.back();
        showErrorMessage(
          context: context,
          builder: (context) => const ModalFitError(),
        );
        // throw Exception('Failed to updated customer.');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }
}
